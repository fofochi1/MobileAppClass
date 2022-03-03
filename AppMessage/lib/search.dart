
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/conversation.dart';
import 'package:fanpage/home_screen.dart';
import 'package:fanpage/post_screen.dart';
import 'package:fanpage/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

User? loggedinUser;

class SearchScreen extends StatefulWidget{
  UserModel user;
  SearchScreen(this.user);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch()async{
    setState((){
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('chatters').where("name", isEqualTo: searchController.text).get().then((value){
      if(value.docs.length < 1){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No User")));
        setState((){
          isLoading = false;
        });
        return;
      }
      value.docs.forEach((user) {
        if(user.data()['email'] != widget.user.email){
          searchResult.add(user.data());
        }
      });
      setState((){
        isLoading = true;
    });
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                padding: const EdgeInsets.all(15.0),
                child:TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Type user",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              ),
              ),
              IconButton(onPressed: (){
                onSearch();

              }, icon: Icon(Icons.search))
              
            ]
          ),
          if(searchResult.length > 0)
            Expanded(child: ListView.builder(
              itemCount: searchResult.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(searchResult[index]["name"]),
                  trailing: IconButton(onPressed: (){
                    setState((){
                      searchController.text = '';
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>conversationScreen(
                      currentUser: widget.user,
                      toID: searchResult[index]['uid'],
                      toName: searchResult[index]['name'],
                    )));
                  }, icon: Icon(Icons.message)),
                );
              }
            ))
          else if(isLoading == true)
            Center(child: CircularProgressIndicator(),)
        ],
      )
    );
  }
}