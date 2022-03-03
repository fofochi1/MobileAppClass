import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/auth_screen.dart';
import 'package:fanpage/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'post_screen.dart';
import 'conversation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SplashScreen());
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<Widget> userSigned()async{
    User? user = FirebaseAuth.instance.currentUser;
        if(user != null){
          DocumentSnapshot userData = await FirebaseFirestore.instance.collection('chatters').doc(user.uid).get();
          UserModel userModel = UserModel.fromJson(userData);
          return HomeScreen(userModel);
        }else{
          return AuthScreen();
        }
    }

  const MyApp({Key? key}) : super(key: key);

  //This widget is the root of the app
  @override
  Widget build(BuildContext context){
    return MaterialApp(
     
      home: FutureBuilder(
        future: userSigned(),
        builder: (context, AsyncSnapshot<Widget> snapshot){
          if(snapshot.hasData){
            return snapshot.data!;
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
    ));
  }
}

class SplashScreen extends StatelessWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
    
    home: AnimatedSplashScreen(
      splash: Image.asset('assets/alfonso.png'),
      duration: 3000,
      backgroundColor: Colors.blue,
      nextScreen: const MyApp(),
    ),
    );
  }
}
