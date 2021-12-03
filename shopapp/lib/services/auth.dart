import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<User> googleSignIn();
}

/*class Auth implements BaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<User> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);

    try {
      UserCredential user =
          await _firebaseAuth.signInWithCredential(credential);
      return user;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
}*/
