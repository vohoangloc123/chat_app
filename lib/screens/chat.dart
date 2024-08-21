import 'package:chat_app/widgets/chat_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    print('Token: $token'); // print the token to the console
  }

  @override
  void initState() {
    super.initState();
    final fcm = FirebaseMessaging.instance;
    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              // sign out the user
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: ChatMessage()),
          NewMessage(),
        ],
      ),
    );
  }
}
