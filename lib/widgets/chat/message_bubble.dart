import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final bool isMe;
  final String image;
  final Key key;

  MessageBubble(this.message, this.username, this.isMe, this.image, {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color:
                      isMe ? Theme.of(context).accentColor : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                width: 140,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMe ? Colors.white : Colors.black),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                            color: isMe ? Colors.white : Colors.black),
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                      ),
                    ]),
              ),
            ]),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        )
      ],
      overflow: Overflow.visible,
    );
  }
}
