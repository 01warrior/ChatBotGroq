// main.dart
import 'package:flutter/material.dart';
import 'package:chatscreen/models/message.dart';
import 'package:chatscreen/services/api_service.dart';
import 'package:chatscreen/widgets/chat_input.dart';
import 'package:chatscreen/widgets/chat_list.dart';
import 'package:chatscreen/widgets/welcome_screen.dart';
import 'package:chatscreen/config.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

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
          seedColor: Colors.blue,
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
  String _selectedModel = AppConfig.defaultModel;

  final List<String> _suggestions = [
    "Parlez-moi de vous.",
    "Donne-moi une astuce de productivité.",
    "Recommande-moi un film ou une série à regarder.",
  ];

  Future<void> _sendMessage(String text) async {
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(Message(role: 'user', content: text));
      _isLoading = true;
    });

    // Build conversation history
    List<Map<String, dynamic>> conversation = [];
    for (var msg in _messages) {
      conversation.add({"role": msg.role, "content": msg.content});
    }

    try {
      final response =
          await _apiService.sendMessage(conversation, _selectedModel);
      setState(() {
        _messages.add(Message(role: 'assistant', content: response));
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
        title: const Text('01WARRIOR'),
        centerTitle: false,
        actions: [
          Text(
            _selectedModel.split('/').last,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          PopupMenuButton<String>(
            onSelected: (String model) {
              setState(() {
                _selectedModel = model;
              });
            },
            itemBuilder: (BuildContext context) {
              return AppConfig.availableModels.map((String model) {
                return PopupMenuItem<String>(
                  value: model,
                  child: Text(model),
                );
              }).toList();
            },
            icon:
                const Icon(FluentIcons.brain_24_regular, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? WelcomeScreen(
                    suggestions: _suggestions,
                    onSuggestionTap: _sendMessage,
                  )
                : ChatList(messages: _messages),
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
