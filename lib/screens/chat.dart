import 'package:chat_app/widgets/chat_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
