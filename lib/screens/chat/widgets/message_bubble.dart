import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final bool isMe;
  final Key key;
  const MessageBubble(this.messageText, this.isMe, {this.key});

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: isMe ? Radius.circular(5) : Radius.circular(0),
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(5),
            ),
            color: isMe ? Colors.grey[400] : Theme.of(context).accentColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 22,
                color: Colors.black12
              )
            ],
          ),
          child: Text(messageText),
        ),
      ],
    );
  }
}
