

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/firestore_constants.dart';

class ChatListProvider {
  final FirebaseFirestore firebaseFirestore;

  ChatListProvider({required this.firebaseFirestore});

  Stream<QuerySnapshot> getStreamFireStore(String pathCollection, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {

      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .where(FirestoreConstants.name, isEqualTo: textSearch)
          .snapshots();

    } else {
      return firebaseFirestore.collection(pathCollection).limit(limit).snapshots();
    }

  }
}
