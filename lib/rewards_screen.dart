import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _userPoints = 120; // رصيد النقاط الحالي للمستخدم
  int _watchedAdsToday = 3; // عدد الإعلانات المشاهدة اليوم
  final int _maxAdsPerDay = 10; // الحد الأقصى للإعلانات اليومية

  void _watchAd() {
    if (_watchedAdsToday < _maxAdsPerDay) {
      setState(() {
        _watchedAdsToday++;
        _userPoints += 10; // ربح 10 نقاط لكل إعلان
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('مبروك! حصلت على 10 نقاط إضافية.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لقد وصلت للحد الأقصى من الإعلانات اليومية.')),
      );
    }
  }

  void _withdrawEarnings() {
    // نافذة أو رسالة تأكيد السحب عبر شام كاش
    showDialog(
      context: DialogContextHelper.context ?? context, // افتراضي للتنبيه
      builder: (context) => AlertDialog(
        title: const Text('سحب الأرباح عبر شام كاش'),
        content: Text(
          'رصيدك الحالي هو $_userPoints نقطة.\n\n'
          'سيتم تحويل الأرباح بعد خصم نسبة الإدارة (الثلث) وإرسال النصيب الأكبر لك (ثلثين) عبر شام كاش (مع توفر التسهيلات لأهلنا في الخليج وباقي المناطق).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تقديم طلب السحب بنجاح عبر شام كاش!')),
              );
            },
            child: const Text('تأكيد السحب'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظام المكافآت والأرباح - متجر نيف'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // بطاقة عرض الرصيد
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.indigo[50],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'رصيدك الحالي من النقاط',
                      style: TextStyle(fontSize: 16, color: Colors.indigo),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_userPoints نقطة',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // بطاقة مشاهدة الإعلانات
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'شاهد الإعلانات واجمع النقاط',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'شاهدت اليوم: $_watchedAdsToday من أصل $_maxAdsPerDay إعلانات متاحة.',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _watchAd,
                      icon: const Icon(Icons.play_circle_filled, color: Colors.white),
                      label: const Text(
                        'شاهد إعلان واكسب النقاط',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // زر سحب الأرباح عبر شام كاش
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _withdrawEarnings,
              child: const Text(
                'سحب الأرباح عبر شام كاش',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// كلاس مساعد بسيط لضمان سياق الرسائل
class DialogContextHelper {
  static BuildContext? context;
}
