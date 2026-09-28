import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'rewards_screen.dart';

void main() {
  runApp(const NeefStoreApp());
}

class NeefStoreApp extends StatelessWidget {
  const NeefStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'متجر نيف',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainContainerScreen(),
    );
  }
}

class MainContainerScreen extends StatefulWidget {
  const MainContainerScreen({super.key});

  @override
  State<MainContainerScreen> createState() => _MainContainerScreenState();
}

class _MainContainerScreenState extends State<MainContainerScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const RewardsScreen(),
    const ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية والألعاب',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'الأرباح (شام كاش)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'الدردشة',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('متجر نيف - الرئيسية'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'مرحباً بك في عالم الألعاب والتشويق!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildCategoryCard(
            context,
            title: 'لعبة القناص والرماية (HD)',
            subtitle: 'تصويب واقعي ومغامرة حماسية',
            icon: Icons.gps_fixed,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 12),
          _buildCategoryCard(
            context,
            title: 'لعبة طرنيب وتريكس',
            subtitle: 'ألعاب الورق الجماعية الممتعة',
            icon: Icons.style,
            color: Colors.amber.shade700,
          ),
          const SizedBox(height: 12),
          _buildCategoryCard(
            context,
            title: 'نظام النقاط والإعلانات',
            subtitle: 'شاهد واربح نقاط لشام كاش',
            icon: Icons.monetization_on,
            color: Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color color}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم اختيار: $title')),
          );
        },
      ),
    );
  }
}
