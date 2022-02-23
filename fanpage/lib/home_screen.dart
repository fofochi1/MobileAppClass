// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_const_constructors


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

User? loggedinUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  void initState() {
    super.initState();
    getCurrentUser();
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }


  
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    bool admin = false;
    if(user.uid == 'OHzUFdlHDsWJNRNlLSyWe2cgWxo2'){
      admin = true;
    }
      return buildButton(context, admin);
  }

  Widget buildButton(BuildContext context, bool admin){
    final dbRef = FirebaseDatabase.instance.reference().child('posts');
    List<Map<dynamic, dynamic>> lists = [];
    final DocumentSnapshot document;

    if(admin){
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                showAlertDialog(context);
                // googleSignIn.disconnect();
                // _auth.signOut();
                // Navigator.pop(context);

                //Implement logout functionality
              }
              ),      
            ],
      ),

       body: StreamBuilder(
         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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
                      Text(document['post'], textAlign: TextAlign.center,),
                      Text(DateFormat('yyyy-MM-dd – kk:mm').format(document['date'].toDate()), textAlign: TextAlign.center,)
                      ]
                    )
                    
                     
                            
                    ),
                );
             },
           ).toList(),
           );
           }
       ),

      bottomNavigationBar: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  PostScreen()),
                    );
                  },
                  child: Icon(Icons.add, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    primary: Colors.blue, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
          );
    }
    else{
      return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                showAlertDialog(context);
                // _auth.signOut();
                // Navigator.pop(context);

              }),      
            ],
      ),
      body: StreamBuilder(
         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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
                    width: MediaQuery.of(context).size.width/1.2,
                    height: MediaQuery.of(context).size.height/6,
                    child: Column(
                      children: [
                      Text(document['post'], textAlign: TextAlign.center,),
                      Text(DateFormat('yyyy-MM-dd – kk:mm').format(document['date'].toDate()), textAlign: TextAlign.center,)
                      ]
                    )                     
                            
                    ),
                );
             },
           ).toList(),
           );
           }
       ),

      );
    }
    
  }

  showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
        Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Logout"),
    onPressed:  () {
      googleSignIn.disconnect();
      _auth.signOut();
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Are you sure"),
    content: Text("Would you like to continue with logging off?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
  
}

