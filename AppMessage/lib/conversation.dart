
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/user_model.dart';
import 'package:fanpage/widgets/message_text.dart';
import 'package:fanpage/widgets/single.dart';
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('chatters').doc(currentUser.uid).collection('messages').doc(toID).collection('chats').orderBy("date",descending:true).snapshots(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  if(snapshot.data.docs.length < 1){
                    return Center(
                      child: Text("Say something")
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index){
                      bool isMe = snapshot.data.docs[index]['senderId'] == currentUser.uid;
                      return Single(message: snapshot.data.docs[index]['message'], isMe: isMe);
                    }
                  );
                }
                return Center(
                  child: CircularProgressIndicator()
                );
                }
            ),
          )),
          MessageField(currentUser.uid, toID),
        ],
      )
    );
  }
}