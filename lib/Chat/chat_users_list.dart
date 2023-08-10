import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/Models/firestore_constants.dart';
import 'package:darl_dispatch/Models/user_chat_model.dart';
import 'package:darl_dispatch/Utils/progress_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Utils/debouncer.dart';
import '../General/sample_page.dart';
import 'chat_list_provider.dart';
import 'chat_page.dart';

class ChatUsersList extends StatefulWidget {
  const ChatUsersList({Key? key}) : super(key: key);

  @override
  State<ChatUsersList> createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  bool isLoading = false;
  late final ChatListProvider chatListProvider = context.read<ChatListProvider>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController searchBarTec = TextEditingController();
  final StreamController<bool> btnClearController = StreamController<bool>();
  final Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");

  int _limit = 20;
  String _textSearch = "";

  List<QueryDocumentSnapshot<Object?>>? userMap;

  late final String currentUsrId;

  @override
  void initState() {
    if(firebaseAuth.currentUser!.uid.isNotEmpty == true){
      currentUsrId = firebaseAuth.currentUser!.uid;
    }
    else{
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Samplepage()),
          //  (Route<dynamic> route) => false,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(height: 2.h,),
                    builSearchBar(),
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: chatListProvider.getStreamFireStore(FirestoreConstants.pathUserCollection,
                              _limit, _textSearch),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {

                            if (snapshot.hasData) {
                              if ((snapshot.data?.docs.length ?? 0) > 0) {

                                return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) => buildItem(
                                        context, snapshot.data?.docs[index]));
                              } else {
                                return Center(
                                  child: Text("No users"),
                                );
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              );
                            }
                          },
                        ))
                  ],
                ),

                Positioned(
                  child: isLoading ? ProgressBar() : SizedBox.shrink(),
                )
              ],
            ),
          ));
  }

  Widget builSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
       border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search, color: Colors.grey, size: 20),
          SizedBox(width: 5),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: searchBarTec,
              onChanged: (value) {
                searchDebouncer.run(() {
                  if (value.isNotEmpty) {
                    btnClearController.add(true);
                    setState(() {
                      _textSearch = value;
                    });
                  } else {
                    btnClearController.add(false);
                    setState(() {
                      _textSearch = "";
                    });
                  }
                });
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search name, Type exact keyword',
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              style: TextStyle(fontSize: 15),
            ),
          ),
          StreamBuilder<bool>(
              stream: btnClearController.stream,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? GestureDetector(
                    onTap: () {
                      searchBarTec.clear();
                      btnClearController.add(false);
                      setState(() {
                        _textSearch = "";
                      });
                    },
                    child: Icon(Icons.clear_rounded, color: Colors.grey, size: 20))
                    : SizedBox.shrink();
              }),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context,
      QueryDocumentSnapshot<Object?>? document) {
    if (document != null) {
      UserChatModel userChatModel = UserChatModel.fromDocument(document);
     // var userStatus  = userChatModel.status;
      if (userChatModel.id == currentUsrId) {
        return SizedBox.shrink();
      } else {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w,),
          child: InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
              arguments: ChatPageArgument(
                peerId: userChatModel.id,
                peerName: userChatModel.name,
                peerAvatar: userChatModel.photoUrl
              ),

            )));
          },
            child: Container(
              height: 8.h,
              child: Card(
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child:
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          userChatModel.photoUrl ?? ""),),
                    SizedBox(width: 3.w,),
                        Text("${userChatModel.name}", style: TextStyle(
                            color: Colors.black87, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                        /*SizedBox(height: 0.5.h,),
                        if(userStatus == "Offline")
                        Text("Offline", style: TextStyle(
                            color: Colors.grey, fontSize: 16.sp, fontWeight: FontWeight.bold)
                        ),
                        if(userStatus == "Online")
                      Text("Online", style: TextStyle(
                       color: Colors.green, fontSize: 16.sp, )
                          ),*/


                          ],
                )
              ),),
            ),
          ),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

}
