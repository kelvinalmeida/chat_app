import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageControler = TextEditingController();

  @override
  void dispose() {
    _messageControler.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enterredMessage = _messageControler.text;

    if (enterredMessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messageControler.clear();

    final user = FirebaseAuth.instance.currentUser!;

    final userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enterredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['userName'],
      'userImage': userData.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 1,
        bottom: 14,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _messageControler,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.send),
            onPressed: _submitMessage,
          )
        ],
      ),
    );
  }
}
