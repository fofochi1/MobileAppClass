// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_const_constructors


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
                      MaterialPageRoute(builder: (context) =>  MyCustomForm(fromID: document['idFrom'], toID: document['idTo'])),
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
    );
  }
}

class ID {
  final String fromID;
  final String toID;

  const ID(this.fromID, this.toID);
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key, required this.fromID, required this.toID}) : super(key: key);

  final String fromID;
  final String toID;

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  late String content;



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
          onChanged: (value) {
              content = value;
           },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () async {
          final User user = auth.currentUser;
          await sendMessage(uid: user.uid).updatePost(content, widget.fromID, widget.toID);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Post!',
        child: const Icon(Icons.post_add),
      ),
    );
  }
}