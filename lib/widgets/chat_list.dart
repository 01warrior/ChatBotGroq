import 'package:flutter/material.dart';
import 'package:chatscreen/models/message.dart';
import 'package:chatscreen/widgets/chat_bubble.dart';

class ChatList extends StatelessWidget {
  final List<Message> messages;

  const ChatList({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      reverse: true,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final message = messages.reversed.toList()[index];
                return ChatBubble(
                  message: message,
                  isUser: message.role == 'user',
                );
              },
              childCount: messages.length,
            ),
          ),
        ),
      ],
    );
  }
}
