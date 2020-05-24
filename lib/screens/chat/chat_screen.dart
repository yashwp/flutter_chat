import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './widgets/messages.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const endPoint = 'chats/Y1MzU5nx4FPQDRmgduU8/messages';
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: <Widget>[
          DropdownButton(
            icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color,),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (identifier) {
              if (identifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages()
            )
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Firestore.instance.collection(endPoint)
                    .add({'text': 'Click by + button'});
              }
            ),
    );
  }
}
