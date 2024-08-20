import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: false)
            .snapshots(),
        builder: (context, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text('No messages yet'),
            );
          }
          if (chatSnapshots.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
          final loadedMessages = chatSnapshots.data?.docs;
          return ListView.builder(
            itemCount: loadedMessages?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(loadedMessages![index].data()['text']),
                subtitle: Text(loadedMessages[index].data()['username']),
              );
            },
          );
        });
  }
}
