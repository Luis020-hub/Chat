import 'package:chat/components/message_bubble.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularPercentIndicator(
              animation: true,
              animationDuration: 900,
              radius: 70.0,
              lineWidth: 8.0,
              percent: 1.0,
              center: const Text(
                "100%",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              progressColor: Colors.white,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Without conversation. Let's talk? :D "),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => MessageBubble(
              key: ValueKey(msgs[i].id),
              message: msgs[i],
              belongsToCurrentUser: currentUser?.id == msgs[i].userId,
            ),
          );
        }
      },
    );
  }
}
