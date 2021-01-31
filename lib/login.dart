import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/routes.dart';

class LoginScreen extends StatelessWidget {
  UserCredential _userCredential;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hi there",
      home: Scaffold(
          body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text("Login"),
                onPressed: () async {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: "parth.champaneri@hotmail.com",
                      password: "Secret");
                  if (FirebaseAuth.instance.currentUser.emailVerified) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    print('unverified');
                  }
                },
              ),
              RaisedButton(
                child: Text("Register"),
                onPressed: () {
                  register_user();
                  // Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  void register_user() async {
    try {
      this._userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "parth.champaneri@hotmail.com", password: "Secret");

      if (!this._userCredential.user.emailVerified) {
        await _userCredential.user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          print('Email address ${_userCredential.user.email} already in use.');
          break;
        case 'invalid-email':
          print('Email address ${_userCredential.user.email} is invalid.');
          break;
        // not sure what this case is for yet
        case 'operation-not-allowed':
          print("Error during sign up");
          break;
        case 'weak-password':
          print(
              "Password is not strong enough. Add additional characters including special characters and numbers.");
          break;
        default:
          print(e.code);
          break;
      }
    } catch (e) {
      print(e);
    }
  }
}
