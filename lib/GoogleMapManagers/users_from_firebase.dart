
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/GoogleMapManagers/users_from_fb_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Models/global_variables.dart';




class UsersFromFirebase extends StatefulWidget {
  const UsersFromFirebase({Key? key}) : super(key: key);


  @override
  _UsersFromFirebaseState createState() => _UsersFromFirebaseState();
}

class _UsersFromFirebaseState extends State<UsersFromFirebase> {

  User? currentUser = FirebaseAuth.instance.currentUser;

  List<QueryDocumentSnapshot<Object?>>? usersMap;

  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose a user to copy the ID",
        style: TextStyle(fontSize: 17.sp),),
      backgroundColor: Colors.indigo,),
      body: _body(),
    );
  }

  Widget _body() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Locations").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> usersSnapshot) {
        if (usersSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.transparent,));
        }
        if (!usersSnapshot.hasData || usersSnapshot.data!.docs.isEmpty) {
          return Center(child: Text("No user found"));
        }

        List<QueryDocumentSnapshot> usersMap = usersSnapshot.data!.docs;

        return ListView.builder(
          itemCount: usersMap.length,
          itemBuilder: (context, index) {
            var document = usersMap[index];

            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(document.id)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                if (!userSnapshot.hasData) {
                  return CircularProgressIndicator(color: Colors.transparent,);
                }

                var userData = userSnapshot.data!.data() as Map<String, dynamic>?;

                if (userData == null) {
                  return SizedBox.shrink();
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        usersName = userData["Name"];
                      });

                      String userAvatar = userData["photoUrl"] ?? "";
                      String userName = userData["Name"] ?? "";
                      String userId = userData["id"] ?? "";

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UsersFromFbDetails(
                            arguments: UsersDetails(
                              userAvatar: userAvatar,
                              userName: userName,
                              userid: userId,
                            ),
                          ),
                        ),
                      );
                      // Rest of the code...
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: Image.network(
                                    userData["photoUrl"] ?? "",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              /*child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection("Users").snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    dynamic userData = snapshot.data?.docs;
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return CircularProgressIndicator(color: Colors.green,);
                                    }else if(snapshot.hasError){
                                      return CircleAvatar(child: Icon(Icons.person),radius: 60,);
                                    }else {
                                      return CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            userData[index]["photoUrl"] ?? ""),);
                                    }
                                  }
                              ),*/
                            ),
                            SizedBox(width: 2.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData["Name"] ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                  ),
                                ),
                                SizedBox(height: 0.5.h,),
                                Text(userData["id"] ?? ""),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }



}
