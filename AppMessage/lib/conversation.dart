// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_const_constructors


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:fanpage/home_screen.dart';

import 'login_screen.dart';

User? loggedinUser;

// class Conversation extends StatefulWidget {
//   Conversation(toID, fromID);

//   @override
//   _Conversation createState() => _Conversation();
// }

// class _Conversation extends State<Conversation> {
//   final _auth = FirebaseAuth.instance;
//   final googleSignIn = GoogleSignIn();

//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   //using this function you can use the credentials of the user
//   void getCurrentUser() async {
//     try {
//       final user = await _auth.currentUser;
//       if (user != null) {
//         loggedinUser = user;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
  
//   @override
//   Widget convo(BuildContext context, bool admin){
//     User user = FirebaseAuth.instance.currentUser;
//     final dbRef = FirebaseDatabase.instance.reference().child('posts');
//     List<Map<dynamic, dynamic>> lists = [];
//     final DocumentSnapshot document;

//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
        
//       ),

//        body: StreamBuilder(
//          stream: FirebaseFirestore.instance.collection('conversations').snapshots(),
//          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//            if(!snapshot.hasData){
//              return Center(
//                child: CircularProgressIndicator(),
//                );
//            }
          
//            return ListView(
//              children: snapshot.data!.docs.map((document){
//                if(document['idFrom'] == user.uid){}
//                 return Column(
//                   children: [
//                     GestureDetector(
//                     onTap:(){
//                       Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) =>  PostScreen()),
//                     );
//                     },
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.blue,
//                         ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     width: MediaQuery.of(context).size.width/1.2,
//                     height: MediaQuery.of(context).size.height/10,
//                     child: Column(
//                       children: [
//                       Text(document['idTo'], textAlign: TextAlign.center,),
//                       ]
//                     )
                    
                     
                            
//                     ),
//                   ]
//                 );
//              },
//            ).toList(),
//            );
//            }
//        ),

//       bottomNavigationBar: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) =>  PostScreen()),
//                     );
//                   },
//                   child: Icon(Icons.add, color: Colors.white),
//                   style: ElevatedButton.styleFrom(
//                     shape: CircleBorder(),
//                     padding: EdgeInsets.all(20),
//                     primary: Colors.blue, // <-- Button color
//                     onPrimary: Colors.red, // <-- Splash color
//                     ),
//                   ),
//           );
//     }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

class Todo {
  final String fromID;
  final String toID;

  const Todo(this.fromID, this.toID);
}


// A Widget that extracts the necessary arguments from
// the ModalRoute.
@override
class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({Key? key}) : super(key: key);

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(args.toID),
    //   ),
    //   body: Center(
    //     child: Text(args.fromID),
    //   ),
    // );
    late String content;
    User user = FirebaseAuth.instance.currentUser;
    final dbRef = FirebaseDatabase.instance.reference().child('posts');
    List<Map<dynamic, dynamic>> lists = [];
    final DocumentSnapshot document;

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(args.toID),
        
      ),

       body: StreamBuilder(
         stream: FirebaseFirestore.instance.collection('messages').snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
           if(!snapshot.hasData){
             return Center(
               child: CircularProgressIndicator(),
               );
           }
          
           return ListView(
             children: snapshot.data!.docs.map((document){
               if(document['idFrom'] == args.fromID && document['idTo'] == args.toID){}
                return Column(
                  children: [
                    GestureDetector(
                    onTap:(){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  PostScreen()),
                    );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: MediaQuery.of(context).size.width/1.2,
                    height: MediaQuery.of(context).size.height/10,
                    child: Column(
                      children: [
                      Text(document['content'], textAlign: TextAlign.center,),
                      ]
                    )    
                    ),
                  ]
                );
             },
           ).toList(),
           );
           }
       ),
       bottomNavigationBar: 
        TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                  content = value;
                  //Do something with username
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter last name')),
      
    );
  }
}