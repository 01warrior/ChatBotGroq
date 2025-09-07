import 'package:flutter/material.dart';

/// Represents a message in the chat.
@immutable
class Message {
  final String role;
  final String content;

  const Message({
    required this.role,
    required this.content,
  });

  Message copyWith({String? role, String? content}) {
    return Message(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }
}
