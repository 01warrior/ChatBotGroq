import 'package:flutter/material.dart';
import 'package:chatscreen/models/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isUser) const Spacer(),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser
                    ? Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.9)
                    : Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                backgroundBlendMode: BlendMode.srcOver,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isUser ? 'Vous' : 'Assistant',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isUser
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isUser ? message.user : message.ai,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          if (!isUser) const Spacer(),
        ],
      ),
    );
  }
}
