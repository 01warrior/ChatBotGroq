# ChatScreen

Projet Flutter minimaliste servant de base pour intégrer un chatbot et expérimenter des modèles IA.

## Description
Base fonctionnelle et modulaire : écran de conversation, gestion des échanges, et points d'intégration clairs pour appeler un modèle IA (HTTP). Conçu pour prototyper rapidement et s'intégrer dans des architectures backend existantes.

## Fonctionnalités
- Interface de conversation prête à l’emploi  
- Points d’intégration pour appels IA (HTTP/REST)  
- Organisation modulaire du code (UI / logique métier / services)  
- Facile à étendre : stockage, authentification, multithreading

## Installation rapide
```bash
git clone https://github.com/01warrior/ChatBotGroq
cd chatscreen
flutter pub get
flutter run

lib/
├─ main.dart
├─ screens/
│  └─ chat_screen.dart
├─ services/
│  └─ ai_service.dart
├─ models/
│  └─ message.dart
└─ widgets/
   └─ message_bubble.dart



<img width="779" height="768" alt="Capture d&#39;écran 2025-09-07 224456" src="https://github.com/user-attachments/assets/8834ba7d-a465-4af4-95c0-5bf2ebee4ce5" />
