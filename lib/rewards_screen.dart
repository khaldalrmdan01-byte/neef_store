import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int userPoints = 150; // رصيد النقاط التجريبي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أرباحي ونظام السحب (شام كاش)'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        chats: [],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              color: Colors.teal.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text('رصيدك الحالي من النقاط', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text('$userPoints نقطة', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal)),
                    const SizedBox(height: 12),
                    const Text('اهدِ أصدقائك أو شاهد الإعلانات لزيادة نقاطك وسحبها عبر شام كاش!', textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                // محاكاة مشاهدة إعلان لربح النقاط
                setState(() {
                  userPoints += 50;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('مبروك! ربحت 50 نقطة بمشاهدة الإعلان.')),
                );
              },
              icon: const Icon(Icons.play_circle_fill, color: Colors.white),
              label: const Text('شاهد إعلان واربح نقاط', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                // نافذة أو تنبيه طلب السحب عبر شام كاش
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('طلب سحب الأرباح'),
                    content: const Text('سيتم تحويل الأرباح عبر حساب شام كاش الخاص بك قريباً.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('موافق'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
              label: const Text('سحب الأرباح (عبر شام كاش)', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
