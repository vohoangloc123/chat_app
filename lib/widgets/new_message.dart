import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus(); // close the keyboard
    _messageController.clear();
    final user = FirebaseAuth.instance.currentUser; // get the current user
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get(); // get the user data
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid, // add the user id
      'username': userData.data()!['username'], // add the username
      'userImage': userData.data()!['image_url'], // add the user image url
    });
    print(enteredMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Send a message...',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface), // Màu của đường gạch dưới khi không focus
                ),
              ),
              autocorrect: true,
              enableSuggestions: true,
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.onSurface,
            icon: const Icon(Icons.send),
            onPressed: _submitMessage,
          ),
        ],
      ),
    );
  }
}
