import 'dart:html';

import 'package:fanpage/user_model.dart';
import 'package:fanpage/widgets/message_text.dart';
import 'package:flutter/material.dart';

class conversationScreen extends StatelessWidget {
  final UserModel currentUser;
  final String toID;
  final String toName;

  conversationScreen({
    required this.currentUser,
    required this.toID,
    required this.toName
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Text(toName,style: TextStyle(fontSize:20),)
          ],
        )
      ),

      body: Column(
        children: [
          Expanded(child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25)
              )
              
            ),
            child: Container(),
          )),
          MessageField(currentUser.uid, toID),
        ],
      )
    );
  }
}