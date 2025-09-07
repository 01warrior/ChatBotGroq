import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatscreen/main.dart';
import 'package:chatscreen/models/message.dart';

void main() {
  group('Message Model Tests', () {
    test('Message creation', () {
      final message = Message(role: 'user', content: 'Hello');
      expect(message.role, 'user');
      expect(message.content, 'Hello');
    });

    test('Message copyWith', () {
      final message = Message(role: 'user', content: 'Hello');
      final updated = message.copyWith(content: 'Hi');
      expect(updated.role, 'user');
      expect(updated.content, 'Hi');
    });
  });

  testWidgets('ChatApp renders correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const ChatApp());

    // Vérifier que l'AppBar est présente
    expect(find.text('AI Assistant'), findsOneWidget);

    // Vérifier que l'écran de bienvenue est affiché (liste vide)
    expect(find.text('Bienvenue dans votre assistant IA !'), findsOneWidget);
  });

  testWidgets('Welcome screen shows suggestions', (WidgetTester tester) async {
    await tester.pumpWidget(const ChatApp());
    await tester.pumpAndSettle(); // Attendre que l'animation se termine

    // Vérifier qu'une suggestion est présente
    expect(find.text('Bonjour, comment allez-vous ?'), findsOneWidget);
  });
}
