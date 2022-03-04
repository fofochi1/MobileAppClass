// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_const_constructors


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/auth_screen.dart';
import 'package:fanpage/conversation.dart';
import 'package:fanpage/post_screen.dart';
import 'package:fanpage/profile.dart';
import 'package:fanpage/search.dart';
import 'package:fanpage/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

User? loggedinUser;

class HomeScreen extends StatefulWidget {
  UserModel user;
  HomeScreen(this.user);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("These are your converstaions"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AuthScreen()), (route) => false);
          }, icon: Icon(Icons.logout))
        ],
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chatters').doc(widget.user.uid).collection('messages').snapshots(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.docs.length < 1){
              return Center(
                child: Text("No Conversations"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder:(context, index){
                var friendName = snapshot.data.docs[index].id;
      
                return FutureBuilder(
                  future: FirebaseFirestore.instance.collection('chatters').doc(friendName).get(),
                  builder: (context, AsyncSnapshot asyncSnapshot){
                    if(asyncSnapshot.hasData){
                      var friend = asyncSnapshot.data;
                      return ListTile(
                        title: Text(friend['name']),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => conversationScreen(currentUser: widget.user, toID: friend['uid'], toName: friend['name'])));
                        }
                      );
                    }
                    return LinearProgressIndicator();
                  },
                );
              }
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen(widget.user)));
        },
      )
    );
  }

}