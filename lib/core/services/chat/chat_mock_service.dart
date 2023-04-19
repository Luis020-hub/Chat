// ignore_for_file: annotate_overrides

import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';

import '../../models/chat_user.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Welcome',
      createdAt: DateTime.now(),
      userId: '1',
      userName: 'Admin',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Thanks :)',
      createdAt: DateTime.now(),
      userId: '2',
      userName: 'User 1',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Hello guys',
      createdAt: DateTime.now(),
      userId: '3',
      userName: 'User 2',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageURL,
    );

    _msgs.add(newMessage);
    _controller?.add(_msgs);
    return newMessage;
  }
}
