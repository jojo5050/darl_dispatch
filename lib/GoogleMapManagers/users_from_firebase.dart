
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
      appBar: AppBar(title: Text("Choose a user to copy the ID"),
      backgroundColor: Colors.indigo,),
      body: _body(),
    );
  }

  Widget _body() {

    if(usersMap != null){
      return Container();
    }

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> usersSnapshot){
          usersMap = usersSnapshot.data?.docs;

          if(usersSnapshot.hasData){
              return ListView.builder(
                    itemCount: usersSnapshot.data?.docs.length,
                    itemBuilder: (context, index){
                      var documentId  =  usersSnapshot.data?.docs[index];
                      if(documentId?.id == currentUser?.uid){
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: InkWell(onTap: (){
                          usersName = usersMap![index]["Name"];
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UsersFromFbDetails(
                              arguments: UsersDetails(
                                  userAvatar:  usersMap![index]["photoUrl"],
                                  userName: usersMap![index]["Name"],
                                  userid: usersMap![index]["id"]

                              )

                          ) ));

                        },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: StreamBuilder<QuerySnapshot>(
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
                                    ),
                                  ),
                                 /* CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        usersMap![index]["photoUrl"]
                                    ),
                                  ),*/
                                  SizedBox(width: 2.w,),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(usersMap![index]["Name"],
                                        style: TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 17.sp),),

                                      SizedBox(height: 0.5.h,),
                                      Text(usersMap![index]["id"],),
                                    ],
                                  )

                                ],

                              ),
                            ),

                          ),
                        ),
                      );

                    });

          }
          else {
            return Center(
              child: CircularProgressIndicator(color: Colors.green,),
            );

          }

        });

  }


}
