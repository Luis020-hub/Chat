import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.belongsToCurrentUser,
  });

  final ChatMessage message;
  final bool belongsToCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: belongsToCurrentUser
                ? Colors.grey.shade300
                : Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          width: 180,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Text(
                message.userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: belongsToCurrentUser ? Colors.black : Colors.white,
                ),
              ),
              Text(message.text),
            ],
          ),
        ),
      ],
    );
  }
}
