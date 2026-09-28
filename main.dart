import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const NeefStoreRealApp());
}

class NeefStoreRealApp extends StatelessWidget {
  const NeefStoreRealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neef Store Real',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const MainGameHub(),
    );
  }
}

class MainGameHub extends StatefulWidget {
  const MainGameHub({super.key});

  @override
  State<MainGameHub> createState() => _MainGameHubState();
}

class _MainGameHubState extends State<MainGameHub> {
  int _userCoins = 100;
  double _arrowPull = 0.0;
  int _score = 0;
  
  int _playerCardScore = 0;
  bool _isGameOver = false;

  void _watchAdToEarnCoins() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎬 مشاهدة إعلان بمكافأة'),
        content: const Text('جاري تشغيل الإعلان... (تزويد نقاط اللاعب وتحقيق الأرباح)'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _userCoins += 50;
                _isGameOver = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🎉 تم إضافة 50 نقطة لحسابك!')),
              );
            },
            child: const Text('إغلاق وتلقي المكافأة'),
          ),
        ],
      ),
    );
  }

  void _drawCard() {
    if (_userCoins < 10) {
      _showNoCoinsDialog();
      return;
    }

    final random = Random();
    int cardValue = random.nextInt(11) + 1;

    setState(() {
      _userCoins -= 10;
      _playerCardScore += cardValue;

      if (_playerCardScore > 21) {
        _isGameOver = true;
      }
    });
  }

  void _resetCardGame() {
    setState(() {
      _playerCardScore = 0;
      _isGameOver = false;
    });
  }

  void _showNoCoinsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ رصيدك غير كافٍ!'),
        content: const Text('شاهد إعلاناً قصيراً للحصول على 50 نقطة والاستمرار في اللعب.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _watchAdToEarnCoins();
            },
            child: const Text('📺 مشاهدة إعلان الآن'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛍️ Neef Store | ألعاب وأرباح'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.black, size: 20),
                const SizedBox(width: 4),
                Text(
                  '$_userCoins',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      '🏹 لعبة الرماية التفاعلية',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('النقاط: $_score', style: const TextStyle(fontSize: 16, color: Colors.green)),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _arrowPull = (details.localPosition.dx / 2).clamp(0.0, 100.0);
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        setState(() {
                          if (_arrowPull > 50) {
                            _score += (_arrowPull * 2).toInt();
                          }
                          _arrowPull = 0.0;
                        });
                      },
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned(
                              left: 20 + _arrowPull,
                              child: const Text('🏹', style: TextStyle(fontSize: 40)),
                            ),
                            const Positioned(
                              right: 20,
                              child: Text('🎯', style: TextStyle(fontSize: 50)),
                            ),
                            Positioned(
                              bottom: 5,
                              left: 10,
                              child: Text('قوة السحب: ${_arrowPull.toInt()}% (اسحب ثم اترك)'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      '🃏 لعبة الشدة والنقاط',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'مجموع نقاط الورق: $_playerCardScore',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isGameOver ? Colors.red : Colors.deepPurple,
                      ),
                    ),
                    if (_isGameOver)
                      const Text(
                        '❌ تجاوزت 21! خسرت الجولة. شاهد إعلاناً لاستعادة نقاطك.',
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _isGameOver ? null : _drawCard,
                          icon: const Icon(Icons.style),
                          label: const Text('سحب ورقة (-10 نقاط)'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _resetCardGame,
                          icon: const Icon(Icons.refresh),
                          label: const Text('إعادة'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade700,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: _watchAdToEarnCoins,
              icon: const Icon(Icons.ondemand_video),
              label: const Text('🎬 مشاهدة إعلان للحصول على +50 نقطة مجاناً'),
            ),
          ],
        ),
      ),
    );
  }
}
