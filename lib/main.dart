import 'package:flutter/material.dart';

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
      home: const MainNavigationScreen(),
    );
  }
}

// شاشة التنقل الرئيسية اللي بتجمع كل أقسام التطبيق تحت بعضها بشكل سلس
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatScreen(),
    const RewardsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'الألعاب والواجهة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'الدردشة والمجتمع',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'المكافآت وشام كاش',
          ),
        ],
      ),
    );
  }
}

// 1. شاشة الواجهة والألعاب (القناص وتريكس)
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
            const Text(
              'أهلاً بك في عالم التحدي والربح الحقيقي',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 6),
            const Text(
              'اختر لعبتك المفضلة، نافس الآخرين، واجمع النقاط لتسحب أرباحك.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildGameCard(
                    title: 'لعبة القناص (الرماية الواقعية)',
                    description: 'رسومات حقيقية، دقة عالية، وتحديات قوية.',
                    color: Colors.black87,
                    icon: Icons.gps_fixed,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('جارٍ فتح لعبة القناص الواقعية...')),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildGameCard(
                    title: 'لعبة تريكس والشدة (المجتمع النشط)',
                    description: 'العب وتجانس مع أصدقائك بأجمل جلسات الورق.',
                    color: Colors.green[800]!,
                    icon: Icons.style,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('جارٍ فتح لعبة تريكس والشدة...')),
                      );
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
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 18),
          ],
        ),
      ),
    );
  }
}

// 2. شاشة الدردشة والتواصل
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'sender': 'أحمد', 'text': 'مرحباً شباب، مين جرب لعبة القناص اليوم؟', 'isMe': false},
    {'sender': 'خالد', 'text': 'أهلاً بك، اللعبة واقعية وتجنن!', 'isMe': true},
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages.add({'sender': 'أنا', 'text': _messageController.text, 'isMe': true});
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مجتمع نيف - دردشة اللاعبين'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جارٍ تفعيل المحادثة الصوتية...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['isMe'] as bool;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.indigo[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['sender'],
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isMe ? Colors.indigo[800] : Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(message['text'], style: const TextStyle(fontSize: 15, color: Colors.black87)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions, color: Colors.indigo),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'اكتب رسالتك هنا...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.indigo),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 3. شاشة المكافآت والأرباح وشام كاش
class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _userPoints = 120;
  int _watchedAdsToday = 3;
  final int _maxAdsPerDay = 10;

  void _watchAd() {
    if (_watchedAdsToday < _maxAdsPerDay) {
      setState(() {
        _watchedAdsToday++;
        _userPoints += 10;
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

  void _withdrawEarnings(BuildContext dialogContext) {
    showDialog(
      context: dialogContext,
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
        title: const Text('نظام المكافآت والأرباح - شام كاش'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.indigo[50],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text('رصيدك الحالي من النقاط', style: TextStyle(fontSize: 16, color: Colors.indigo)),
                    const SizedBox(height: 8),
                    Text('$_userPoints نقطة', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigoAccent)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('شاهد الإعلانات واجمع النقاط', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('شاهدت اليوم: $_watchedAdsToday من أصل $_maxAdsPerDay إعلانات متاحة.', style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _watchAd,
                      icon: const Icon(Icons.play_circle_filled, color: Colors.white),
                      label: const Text('شاهد إعلان واكسب النقاط', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Builder(
              builder: (btnContext) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _withdrawEarnings(btnContext),
                child: const Text('سحب الأرباح عبر شام كاش', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
