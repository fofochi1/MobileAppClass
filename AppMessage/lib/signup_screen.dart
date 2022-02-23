import 'package:fanpage/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'rounded_button.dart';


//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String username;
  late String email;
  late String password;
  late String firstname;
  late String lastname;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 241, 253),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              TextField(
                //keyboardType: TextInputType.,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  username = value;
                  //Do something with username
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter username')),
              SizedBox(
                height: 8.0,
              ),

              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password')),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                  firstname = value;
                  //Do something with username
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter first name')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                  lastname = value;
                  //Do something with username
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter last name')),
              SizedBox(
                height: 8.0,
              ),
              
              TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Color.fromARGB(255, 4, 125, 173),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password,);
                        User result = newUser.user;
                    if (newUser != null) {
                      await DatabaseService(uid: result.uid).updateUserData(username, firstname, lastname);
                      Navigator.pushNamed(context, 'home_screen');
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                  
                },
              child: const Text('Register'),

              )
            ],
          ),
        ),
      ),
    );
  }
}