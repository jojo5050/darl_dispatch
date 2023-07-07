

import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  String? trackingId;
  User? firebaseUser;


  CustomUser({this.firebaseUser, this.trackingId});
}