import 'package:flutter/material.dart';
import 'rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Color.fromARGB(255, 4, 125, 173),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'login_screen');
                  },
                  child: const Text('Log In'),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Color.fromARGB(255, 4, 125, 173),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'registration_screen');
                    },
                    child: const Text('Register'),
                    ),
              ]),
        ));
  }
}
