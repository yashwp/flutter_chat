import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.document('chats').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LinearProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data.documents;

        return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (c, index) => Text(chatDocs[index]['text'])
        );
      },
    );
  }
}
