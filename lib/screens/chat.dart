import 'package:chat_app/widget/chat_message.dart';
import 'package:chat_app/widget/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ChatMessage(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
