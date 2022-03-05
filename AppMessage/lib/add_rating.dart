import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/user_model.dart';
import 'package:flutter/material.dart';

class AddRating extends StatefulWidget {
    final String toID;
    UserModel currentID;

    AddRating({
      required this.toID,
      required this.currentID
    });


  @override
  _AddRatingState createState() => _AddRatingState();
}

class _AddRatingState extends State<AddRating> {
  TextEditingController addRatingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
body: Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          Expanded(child: 
          TextField(
            controller: addRatingController,
            decoration: InputDecoration(
              labelText: "Rate them",
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
              String message = addRatingController.text;
              addRatingController.clear();
              await FirebaseFirestore.instance.collection('ratings').doc(widget.toID).set({
                "fromId":widget.currentID.uid,
                "userId":widget.toID,
                "rating": message,
                "type": "text",
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
    ) 
    );
     
      }
}
