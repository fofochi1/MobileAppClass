
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:fanpage/home_screen.dart';
import 'package:fanpage/database.dart';

import 'login_screen.dart';

User? loggedinUser;


final FirebaseAuth auth = FirebaseAuth.instance;


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
  final User user = auth.currentUser;

    var number = FirebaseFirestore.instance
      .collection('ratings')
      .where('userId', isEqualTo: user.uid).get();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Rating"),
      ),

body: StreamBuilder(
         stream: FirebaseFirestore.instance.collection('ratings').where("userId", isEqualTo: user.uid).snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
           if(!snapshot.hasData){
             return Center(
               child: CircularProgressIndicator(),
               );
           }

           return ListView(
             children: snapshot.data!.docs.map((document){
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: MediaQuery.of(context).size.width/1.2,
                    height: MediaQuery.of(context).size.height/10,
                    //child: Text(document['post']),
                    child: Column(
                      children: [
                      Text("One of your ratings is: " + document['rating'].toString(), textAlign: TextAlign.center,),
                      // Text(document['rating'].toString(), textAlign: TextAlign.center,),

                      ]
                    )
                    
                     
                            
                    ),
                );
             },
           ).toList(),
           );
           }
       )
    );  // add scaffold here
  }
}


