
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_constants.dart';

class UserChatModel {
  final String id;
  final String photoUrl;
  final String name;
  final String status;

  const UserChatModel({required this.id, required this.photoUrl,
    required this.name, required this.status });

  Map<String, String> toJson() {
    return {
      FirestoreConstants.name: name,
      FirestoreConstants.photoUrl: photoUrl,
    };
  }

  factory UserChatModel.fromDocument(DocumentSnapshot doc) {
    String photoUrl = "";
    String name = "";
    String status = "";

    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      name = doc.get(FirestoreConstants.name);
      status = doc.get(FirestoreConstants.status);
    } catch (e) {}
    return UserChatModel(
      id: doc.id,
      photoUrl: photoUrl,
      name: name,
      status: status
    );
  }
}