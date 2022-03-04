import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageField extends StatefulWidget{
  final String currentId;
  final String toId;

  MessageField(this.currentId, this.toId);

  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField>{
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          Expanded(child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "send a message",
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0),
                gapPadding: 10,
                borderRadius: BorderRadius.circular(20)
              )
            )
          )),
          SizedBox(width: 20,),
          GestureDetector(
            onTap: ()async{
              String message = controller.text;
              controller.clear();
              await FirebaseFirestore.instance.collection('chatters').doc(widget.currentId).collection('messages').doc(widget.toId).collection('chats').add({
                "senderId":widget.currentId,
                "receiverId":widget.toId,
                "message": message,
                "type": "text",
                "date": DateTime.now(),
              }).then((value){
                FirebaseFirestore.instance.collection('chatters').doc(widget.currentId).collection('messages').doc(widget.toId).set({
                  'last_message':message,
                });
            });

            await FirebaseFirestore.instance.collection('chatters').doc(widget.toId).collection('messages').doc(widget.currentId).collection('chats').add({
              "senderId":widget.currentId,
              "receiverId":widget.toId,
              "message":message,
              "type":"text",
              "date":DateTime.now(),
            }).then((value){
              FirebaseFirestore.instance.collection('chatters').doc(widget.toId).collection('messages').doc(widget.currentId).set({
                'last_message':message,
              });
            });
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Icon(Icons.send, color: Colors.blue,),
            )
          )
        ]
      )
    );
  }
}