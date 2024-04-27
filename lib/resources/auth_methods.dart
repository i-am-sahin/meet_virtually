import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meet_virtually/utils/utils.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signInWithGoogle(BuildContext context) async{
    bool res = false;
    try{
      //Code copied form readme section of flutter_fire

      final GoogleSignInAccount ? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = 
        await _auth.signInWithCredential(credential);
      
      User? user = userCredential.user;


      if(user != null){
        //  User is new , so store the user data to firebase
        if(userCredential.additionalUserInfo!.isNewUser){
          _firestore.collection('users').doc(user.uid).set({
            'username' : user.displayName,
            'uid' : user.uid,
            'profilePhoto' : user.photoURL,
          });
        }
        res = true;
      }

    }
    on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!); // show the error which is fatch from the firebase auth exception!
      res = false;
    }
    return res;
  }
}