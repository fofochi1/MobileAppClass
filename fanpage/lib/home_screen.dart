// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

User? loggedinUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

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
    if(admin){
      return buildButton(context, admin);
    }
    
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);

                //Implement logout functionality
              }),      



                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) =>  PostScreen()),
                //     );
                //   },
                //   child: Icon(Icons.add, color: Colors.white),
                //   style: ElevatedButton.styleFrom(
                //     shape: CircleBorder(),
                //     padding: EdgeInsets.all(20),
                //     primary: Colors.blue, // <-- Button color
                //     onPrimary: Colors.red, // <-- Splash color
                //     ),
                //   )


                  
        ],
        title: Text("Welcome"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Text(
          "Welcome User",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, bool admin){
    final dbRef = FirebaseDatabase.instance.reference().child('posts');
    List<Map<dynamic, dynamic>> lists = [];

    if(admin){
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);

                //Implement logout functionality
              }),      
            ],
      ),

      //  body: StreamBuilder(
      //    stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      //    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      //      if(!snapshot.hasData){
      //        return Center(
      //          child: CircularProgressIndicator(),
      //          );
      //      }

      //      return ListView(
      //        children: snapshot.data!.docs.map((document){
      //           return Center(
      //             child: Container(
      //               width: MediaQuery.of(context).size.width/1.2,
      //               height: MediaQuery.of(context).size.height/6,
      //               child: Text(document['post']),
                     
                            
      //               ),
      //           );
      //        },
      //      ).toList(),
      //      );
      //      }
      //  ),

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
                _auth.signOut();
                Navigator.pop(context);

                //Implement logout functionality
              }),      
            ],
      ),
      body: FutureBuilder(
            future: dbRef.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                Map<dynamic, dynamic> values = snapshot.data!.value;
                values.forEach((key, values) {
                  lists.add(values);
                });
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Name: " + lists[index]["name"]),
                            Text("Age: " + lists[index]["age"]),
                            Text("Type: " + lists[index]["type"]),
                          ],
                        ),
                      );
                    });
              }
              return CircularProgressIndicator();
            })

      );
    }
    
  }
  
}