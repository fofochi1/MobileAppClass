import 'package:animated_splash_screen/animated_splash_screen.dart';
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

  const MyApp({Key? key}) : super(key: key);

  //This widget is the root of the app
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'home_screen': (context) => HomeScreen(),
        'post_screen': (context) => PostScreen(),
        ExtractArgumentsScreen.routeName: (context) =>
        const ExtractArgumentsScreen(),
      },
      
    );
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
