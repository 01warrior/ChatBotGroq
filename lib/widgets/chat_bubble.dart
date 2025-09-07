import 'package:flutter/material.dart';
import 'package:chatscreen/models/message.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

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
    final theme = Theme.of(context);
    final maxWidth = MediaQuery.of(context).size.width * 0.72;

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isUser ? 16 : 4),
      bottomRight: Radius.circular(isUser ? 4 : 16),
    );

    final bubble = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isUser
                ? null
                : theme.colorScheme.surfaceVariant.withOpacity(0.95),
            gradient: isUser
                ? LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.95),
                      const Color.fromARGB(255, 8, 20, 37)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isUser ? 'Vous' : 'Assistant',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isUser
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message.content,
                style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.35,
                    color: isUser ? Colors.white : Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: theme.colorScheme.secondaryContainer,
                child: Text(
                  'AI',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            bubble,
          ] else ...[
            bubble,
            const SizedBox(width: 8),
            Container(
              margin: const EdgeInsets.only(left: 6),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: theme.colorScheme.primary,
                child: Icon(FluentIcons.person_24_regular,
                    size: 18, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
