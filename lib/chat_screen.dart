import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('غرفة الدردشة والتواصل'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ChatBubble(message: 'أهلاً بالجميع في متجر نيف!', isMe: false),
                ChatBubble(message: 'مين حابب يلعب معنا طرنيب أو تريكس؟', isMe: true),
                ChatBubble(message: 'أنا جاهز، خلينا نبدأ!', isMe: false),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.indigo),
                  onPressed: () {
                    // ميزة الدردشة الصوتية
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.emoji_emotions, color: Colors.orange),
                  onPressed: () {
                    // إرسال الملصقات
                  },
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك هنا...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.indigo),
                  onPressed: () {
                    // إرسال الرسالة
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.indigo.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(message, style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}
