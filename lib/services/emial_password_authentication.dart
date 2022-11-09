import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class EmailAndPassword  {
  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "signed in";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'no user found for this email';
      } else if (e.code == 'wrong-password') {
        return 'password is wrong';
      } else {
        return 'invalid email or password';
      }
    }
  }

  Future<String> createUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password,);
     // await FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
      return 'signed up';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'password is too weak';
      } else if (e.code == 'user-already-in-use') {
        return 'user is already exist';
      } else {
        return 'invalid email or password';
      }
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'check your email inbox';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'invalid email';
      } else {
        return 'no user found for this email';
      }
    }
  }
}
