import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:darl_dispatch/Utils/progress_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../General/sample_page.dart';
import 'chat_provider.dart';
import '../../Models/firestore_constants.dart';
import '../../Utils/full_photo_page.dart';
import 'message_chat.dart';

  class ChatPage extends StatefulWidget {
    const ChatPage({Key? key, required this.arguments}) : super(key: key);
    final ChatPageArgument arguments;

    @override
    State<ChatPage> createState() => _ChatPageState();
  }

  class _ChatPageState extends State<ChatPage>  with WidgetsBindingObserver {

    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? currentUser = FirebaseAuth.instance.currentUser;
    final TextEditingController textEditingController = TextEditingController();
    final ScrollController listScrollController = ScrollController();
    final FocusNode focusNode = FocusNode();
    late final FirebaseFirestore firebaseFirestore;

    late final ChatProvider chatProvider = context.read<ChatProvider>();

    bool isShowSticker = false;
    int _limit = 20;
    List<QueryDocumentSnapshot> listMessage = [];
    int _limitIncrement = 20;
    late final String currentUserID;
    String groupChatID = "";
    File? imageFile;
    bool isLoading = false;
    String imageUrl = "";

    bool _hasInternet = true;

    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkInternetConnection();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    getLocal();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.indigo,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding:
             EdgeInsets.only( left: 10, top: 35, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.arrow_back, color: Colors.white, size: 23.sp,)),
               // Icon(Icons.arrow_back, color: Colors.white,),
                SizedBox(width: 4.w,),
                CircleAvatar(backgroundImage: NetworkImage(widget.arguments.peerAvatar),),
                SizedBox(width: 2.w,),
                Text(this.widget.arguments.peerName,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),),
              ],
            ),
          ),
        ),


        body: _hasInternet ? SafeArea(
          child: Stack(children: <Widget>[
            Column(children: <Widget>[
              // List of messages
              buildListMessage(),
              // Sticker
            //  isShowSticker ? buildSticker() : SizedBox.shrink(),
              // Input content
              buildInput(),
             ],
            ),
            // Loading
            buildLoading()

        ],),)
            : buildNoInternetPopup(),

      );
    }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

   _scrollListener() {
     if (!listScrollController.hasClients) return;
     if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
         !listScrollController.position.outOfRange &&
         _limit <= listMessage.length) {
       setState(() {
         _limit += _limitIncrement;
       });
     }

  }

      void getLocal() {
        if (!_hasInternet) {
          return;
        }
      if(firebaseAuth.currentUser!.uid.isNotEmpty == true){
        currentUserID = firebaseAuth.currentUser!.uid;
      } else{
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Samplepage()),
          //  (Route<dynamic> route) => false,
        );
      }

      String peerID = widget.arguments.peerId;
      if(currentUserID.compareTo(peerID) > 0){
        groupChatID = '$currentUserID-$peerID';
      }else{
        groupChatID = '$peerID-$currentUserID';
      }

      chatProvider.updateDataFirestore(
        FirestoreConstants.pathUserCollection,
        currentUserID,
        {FirestoreConstants.chattingWith: peerID},
      );

  }

   /* Future getImage() async {
      ImagePicker imagePicker = ImagePicker();
      XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery).catchError((err) {
        Fluttertoast.showToast(msg: err.toString());
        return null;
      });
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        if (imageFile != null) {
          setState(() {
            isLoading = true;
          });
          uploadFile();
        }
      }
    }*/
    void getSticker() {
      // Hide keyboard when sticker appear
      focusNode.unfocus();
      setState(() {
        isShowSticker = !isShowSticker;
      });
    }


  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendMessage(content, type, groupChatID, currentUserID!, widget.arguments.peerId);
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(msg: 'Enter a Message', backgroundColor: Colors.grey);
    }

  }

    Widget buildListMessage() {
      return Flexible(
        child: groupChatID.isNotEmpty
            ? StreamBuilder<QuerySnapshot>(
          stream: chatProvider.getChatStream(groupChatID, _limit),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              listMessage = snapshot.data!.docs;

              if (listMessage.length > 0) {
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) => buildItem(index, snapshot.data?.docs[index]),
                  itemCount: snapshot.data?.docs.length,
                  reverse: true,
                  controller: listScrollController,
                );
              } else {
                return Center(child: Text("No message here yet...",
                  style: TextStyle(color: Colors.black, fontSize: 17.sp) ,));
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
          },
        )
            : const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      );
    }

    Widget buildInput() {
      return Container(
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5)), color: Colors.white),
        child: Row(
          children: <Widget>[
            // Button send image
            Material(
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 1),
                child: IconButton(
                  icon: Icon(Icons.image),
                  onPressed: getImage,
                  color: Colors.black54,
                ),
              ),
            ),
            // Edit text
            Flexible(
              child: Container(
                child: TextField(
                  onSubmitted: (value) {
                    onSendMessage(textEditingController.text, TypeMessage.text);
                  },
                  style: TextStyle(color: Colors.indigo, fontSize: 16),
                  controller: textEditingController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  focusNode: focusNode,
                  autofocus: true,
                ),
              ),
            ),

            // Button send message
            Material(
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  icon: Icon(Icons.send, size: 25.sp,),
                  onPressed: () => onSendMessage(textEditingController.text, TypeMessage.text),
                  color: Colors.indigo,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildLoading() {
      return Positioned(
        child: isLoading ? ProgressBar() : SizedBox.shrink(),
      );
    }

    Widget buildItem(int index, DocumentSnapshot? document) {
      if (document != null) {
        MessageChat messageChat = MessageChat.fromDocument(document);
        if (messageChat.idFrom == currentUserID) {
          // Right (my message)
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              messageChat.type == TypeMessage.text
              // Text
                  ? Container(
              //  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                width: 200,
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
                child: Text(
                      messageChat.content,
                      style: TextStyle(color: Colors.white, fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
                ),
              )
                  : messageChat.type == TypeMessage.image
              // Image
                  ? Container(
                margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
                child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullPhotoImage(
                              url: messageChat.content,
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          messageChat.content,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              width: 200,
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return Material(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image.asset(
                                'images/img_not_available.jpeg',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                ),
              )
              // Sticker
                  : Container(
                margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
                child: Image.asset(
                  'images/${messageChat.content}.gif',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        } else {
          // Left (peer message)
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    isLastMessageLeft(index)
                        ? Material(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(widget.arguments.peerAvatar,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.indigo,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, object, stackTrace) {
                          return const Icon(
                            Icons.account_circle,
                            size: 35,
                            color: Colors.grey,
                          );
                        },
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                      )

                    )
                        : Container(width: 35),
                    messageChat.type == TypeMessage.text
                        ? Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      width: 200,
                      decoration:
                      BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        messageChat.content,
                        style: TextStyle(color: Colors.white, fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                        : messageChat.type == TypeMessage.image
                        ? Container(
                      margin: EdgeInsets.only(left: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullPhotoImage(url: messageChat.content),
                            ),
                          );
                        },
                        style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            messageChat.content,
                            loadingBuilder:
                                (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                width: 200,
                                height: 200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, object, stackTrace) => Material(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image.asset(
                                'images/img_not_available.jpeg',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                        : Container(
                      margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
                      child: Image.asset(
                        'images/${messageChat.content}.gif',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                // Time
                isLastMessageLeft(index)
                    ? Container(
                  margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
                  child: Text(
                    DateFormat('dd MMM kk:mm')
                        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(messageChat.timestamp))),
                    style: const TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                )
                    : SizedBox.shrink()
              ],
            ),
          );
        }
      } else {
        return SizedBox.shrink();
      }
    }

    bool isLastMessageRight(int index) {
      if ((index > 0 && listMessage[index - 1].get(FirestoreConstants.idFrom) != currentUserID) || index == 0) {
        return true;
      } else {
        return false;
      }
    }

    bool isLastMessageLeft(int index) {
      if ((index > 0 && listMessage[index - 1].get(FirestoreConstants.idFrom) == currentUserID) || index == 0) {
        return true;
      } else {
        return false;
      }
    }

    Future getImage() async {
      ImagePicker imagePicker = ImagePicker();
      XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery).catchError((err) {
        Fluttertoast.showToast(msg: err.toString());
        return null;
      });
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        if (imageFile != null) {
          setState(() {
            isLoading = true;
          });
          uploadFile();
        }
      }
    }

    Future uploadFile() async {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      UploadTask uploadTask = chatProvider.uploadFile(imageFile!, fileName);
      try {
        TaskSnapshot snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          isLoading = false;
          onSendMessage(imageUrl, TypeMessage.image);
        });
      } on FirebaseException catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: e.message ?? e.toString());
      }
    }

    Future<void> checkInternetConnection() async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {
          _hasInternet = false;
        });
      } else {
        setState(() {
          _hasInternet = true;
        });
      }
    }

    Widget buildNoInternetPopup() {
      return Center(
        child: Container(
          height: 23.h,
          child: Dialog(
            backgroundColor: Colors.grey,
            child: Column(
              children: [
                SizedBox(height: 2.h,),
                const Center(child: Text("No Internet access Detected",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                SizedBox(height: 1.h,),
                const Center(child: Text("Re-Connect and try again",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                //  SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          exitApp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 5.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Exit", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),),
                          ),
                        )),

                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/splash_screen');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 5.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Reload", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),),
                          ),
                        )),

                  ],)
              ],
            ),
          ),
        ),
      );

    }

    exitApp() {
      Future.delayed(const Duration(milliseconds: 1000), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    }
}

  class ChatPageArgument {
    final String peerId;
    final String peerName;
    final String peerAvatar;

    ChatPageArgument({required this.peerId, required this.peerName, required this.peerAvatar});
  }
