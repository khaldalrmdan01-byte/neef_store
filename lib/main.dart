import 'package:flutter/material.dart';
// استيراد الشاشات الأخرى إذا لزم الأمر
// import 'chat_screen.dart';
// import 'rewards_screen.dart';

void main() {
  runApp(const NeefStoreApp());
}

class NeefStoreApp extends StatelessWidget {
  const NeefStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neef Store - متجر نيف',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('متجر نيف - Neef Store'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ترحيب والكلمات المفتاحية للتطبيق
            const Text(
              'أهلاً بك في عالم التحدي والربح الحقيقي',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'اختر لعبتك المفضلة، نافس الآخرين، واجمع النقاط لتسحب أرباحك عبر شام كاش.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            
            // قسم الألعاب (قناص + تريكس)
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 2.2,
                mainAxisSpacing: 16,
                children: [
                  // بطاقة لعبة القناص (الواقعية)
                  _buildGameCard(
                    title: 'لعبة القناص (الرماية الواقعية)',
                    description: 'رسومات حقيقية، دقة عالية، وتحديات قوية.',
                    color: Colors.black87,
                    icon: Icons.gps_fixed,
                    onTap: () {
                      // هون رح نضيف الانتقال لشاشة القناص لاحقاً
                    },
                  ),
                  
                  // بطاقة لعبة تريكس والشدة
                  _buildGameCard(
                    title: 'لعبة تريكس والشدة (المجتمع النشط)',
                    description: 'العب وتجانس مع أصدقائك بأجمل جلسات الورق.',
                    color: Colors.green[800]!,
                    icon: Icons.style,
                    onTap: () {
                      // هون رح نضيف الانتقال لشاشة تريكس لاحقاً
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لتصميم بطاقات الألعاب بشكل مرتب وواضح
  Widget _buildGameCard({
    required String title,
    required String description,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}
