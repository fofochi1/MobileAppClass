
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/conversation.dart';
import 'package:fanpage/home_screen.dart';
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
        User user = FirebaseAuth.instance.currentUser;

    List<Map<dynamic, dynamic>> lists = [];
    final DocumentSnapshot document;

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
                
            ],
      ),

       body: StreamBuilder(
         stream: FirebaseFirestore.instance.collection('users').snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
           if(!snapshot.hasData){
             return Center(
               child: CircularProgressIndicator(),
               );
           }

           return ListView(
             children: snapshot.data!.docs.map((document){
               if(document['uid'] == user.uid){}
                return Column(
                  children: [
                    GestureDetector(
                    onTap:(){
                      Navigator.pushNamed(
                      context,
                      ExtractArgumentsScreen.routeName,
                      arguments: ScreenArguments(
                        user.uid,
                        document['uid']
                      ),
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
                      Text(document['username'], textAlign: TextAlign.center,),
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
}

  


