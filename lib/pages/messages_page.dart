import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_none, size: 56, color: Colors.red),
          SizedBox(height: 12),
          Text(
            '暂无消息',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text('订单动态和优惠提醒会显示在这里', style: TextStyle(color: Color(0xFF69645D))),
        ],
      ),
    );
  }
}
