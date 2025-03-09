// main.dart
import 'package:flutter/material.dart';
import 'package:chatscreen/models/message.dart';
import 'package:chatscreen/services/api_service.dart';
import 'package:chatscreen/widgets/chat_bubble.dart';
import 'package:chatscreen/widgets/chat_input.dart';

void main() => runApp(const ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  Future<void> _sendMessage(String text) async {
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(Message(user: text, ai: ''));
      _isLoading = true;
    });

    try {
      final response = await _apiService.sendMessage(text);
      setState(() {
        _messages.last = _messages.last.copyWith(ai: response);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              reverse: true,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final message = _messages.reversed.toList()[index];
                        return ChatBubble(
                          message: message,
                          isUser: message.ai.isEmpty,
                        );
                      },
                      childCount: _messages.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ChatInput(
            onSend: _sendMessage,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
