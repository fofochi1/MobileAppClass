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