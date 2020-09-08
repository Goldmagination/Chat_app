import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatData = chatSnapshot.data.documents;
        final userID = FirebaseAuth.instance.currentUser.uid;

        return ListView.builder(
          reverse: true,
          itemCount: chatData.length,
          itemBuilder: (ctx, i) => MessageBubble(
            chatData[i].get('texy'),
            chatData[i].get('username'),
            chatData[i].get('userId') == userID,
            chatData[i].get('userImage'),
            key: ValueKey(chatData[i].documentID),
          ),
        );
      },
    );
  }
}
