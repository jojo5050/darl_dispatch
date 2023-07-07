

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/Authentication/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Models/fb_auth_model.dart';

class FbAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");

  final SignUpPage aa = SignUpPage();

  Future regWithEmailAndPassword(
      String email, String password) async {

    try {
      User? firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password)).user;

      if(firebaseUser != null){
           return userCollection.doc(_firebaseAuth.currentUser?.uid).set({

           });

      }


    } on FirebaseAuthException catch(e){
      var errorMsg = "An error has occurred";
      switch(e.code){
        case "email-already-in-use":
          errorMsg = "The Email Address already exist pls";
          break;

        case "operation-not-allowed":
          errorMsg = "The User Account is not enabled";
          break;

        case "invalid-email":
          errorMsg = "The Email Address is not valid";
          break;
      }
      rethrow;
    }
  }


  // signin with email and password
  Future signInWithEmailAndPassword(
      String email, String password) async {
    try {
      User? firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).user;


    } on FirebaseAuthException catch(e){

      var errMssg = "An error has occurred ";
      switch(e.code){
        case "invalid-email":
          errMssg = "the email address is invalid";
          break;

        case "user-disabled":
          errMssg = "the user has been disabled";
          break;

        case "wrong-password":
          errMssg = "You entered a wrong password";
          break;

        case "user-not-found":
          errMssg = "No user found for the given credentials";
          break;
      }
      rethrow;
    }
  }
}