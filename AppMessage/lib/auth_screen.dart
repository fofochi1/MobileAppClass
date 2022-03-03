import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget{

  @override 
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>{

  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signInFunction()async{
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser == null){
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist = await firestore.collection("chatters").doc(userCredential.user!.uid).get();

    if(userExist.exists){
      print("user exists already");
    }else{
      await firestore.collection('chatters').doc(userCredential.user!.uid).set({
      'email': userCredential.user!.email,
      'name': userCredential.user!.displayName,
      'uid': userCredential.user!.uid
    });
    }

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MyApp()), (route) => false);

    
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Message App", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

            ElevatedButton(onPressed: ()async{
              await signInFunction();

            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Sign in with Google")]

            ))
          ]
        )
      )
    );
  }
}