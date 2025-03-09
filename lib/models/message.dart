import 'package:flutter/material.dart';

@immutable
class Message {
  final String user;
  final String ai;

  const Message({
    required this.user,
    required this.ai,
  });

  Message copyWith({String? user, String? ai}) {
    return Message(
      user: user ?? this.user,
      ai: ai ?? this.ai,
    );
  }
}
