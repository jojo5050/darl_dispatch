import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/AuthManagers/authRepo.dart';
import 'package:darl_dispatch/Models/firestore_constants.dart';
import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Utils/image_picker_manager.dart';
import '../../Utils/localstorage.dart';
import '../../Utils/progress_bar.dart';
import '../../Utils/routers.dart';
import '../Models/global_variables.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with FormValidators {

  ImagePickerManager imagePickerManager = ImagePickerManager();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");

  var successMssg;
  var resetPassErrorMssg;

  final GlobalKey<FormState> updateInfoFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool loading = false;
  bool imageLoading = false;
  String? userName;
  var email;
  var telNum;
  var address;
  var bankName;
  var accNum;

  TaskSnapshot? imageSnapshot;

  String? downloadUrl;

  var error;

  File? imageFile;

  File? image;
  File? profileImage;

  String? base64Image;

  var success;

  var messageValue;


  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  nameController = TextEditingController(text: userName);
   telController = TextEditingController(text: telNum);
   bankNameController = TextEditingController(text: bankName);
  accNumController = TextEditingController(text: accNum);
    addressController = TextEditingController(text: address);
   emailController = TextEditingController(text: email);
    return Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.indigo,
           title: const Text("Edit Profile", style: TextStyle(color: Colors.white,
               fontWeight: FontWeight.bold)),
         ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Form(
            key: updateInfoFormKey,
            child: Column(children: [
              InkWell(onTap: (){
                _getImage(context);
                },
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(70)),
                      child: profileImage != null
                          ? CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(profileImage!),
                        backgroundColor: Colors.transparent,
                      )
                          : const CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.transparent,
                        child: Center(child: Icon(Icons.person,
                          color: Colors.white, size: 100,)),),
                    ),
                    const Positioned(
                        bottom: 12,
                        right: 1,
                        child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
            ),

              SizedBox(height: 1.h,),
               Container(
                child: profilePic != null ?
                imageLoading ? ProgressBar() :

                TextButton(onPressed: (){
                  setState(() {
                    imageLoading = true;
                  });
                  uploadImageToFirestore(profileImage!);
                  uploadToApi(imageData: profileImage, );

                  },
                    child: Text("Upload ",
                      style: TextStyle(fontSize: 18.sp, color: Colors.indigo,
                          fontWeight: FontWeight.bold),))
                    : Container(
                     height: 0,
                      width: 0
                )
              ),

              Align(alignment: Alignment.centerLeft,
                  child: Text("Full Name", style: TextStyle(color: Colors.black,))),
              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Colors.black)),
                    controller: nameController,
                   validator: validateName,
                     onChanged: (String val){
                        userName = val;
                      },
              ),


              SizedBox(
                height: 1.h,
              ),
              Align(alignment: Alignment.centerLeft,
                  child: Text("Email", style: TextStyle(color: Colors.black,))),
              SizedBox(height: 0.5.h,),

              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.black)),
                controller: emailController,
                validator: validateEmail,
                onChanged: (String val){
                  email = val;
                },
              ),
              SizedBox(
                height: 1.h,
              ),
              Align(alignment: Alignment.centerLeft,
                  child: Text("Telephone", style: TextStyle(color: Colors.black,))),
              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Telephone",
                    hintStyle: TextStyle(color: Colors.black)),
                controller: telController,
                validator: validatePhoneNum,
                onChanged: (String val){
                  telNum = val;
                },
              ),
              SizedBox(
                height: 1.h,
              ),
              Align(alignment: Alignment.centerLeft,
                  child: Text("Bank Name", style: TextStyle(color: Colors.black,))),
              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Bank Name",
                    hintStyle: TextStyle(color: Colors.black)),
                controller: bankNameController,
                validator: validateBankName,
                onChanged: (String val){
                  bankName = val;
                },
              ),
              SizedBox(
                height: 1.h,
              ),

              Align(alignment: Alignment.centerLeft,
                  child: Text("Account Number", style: TextStyle(color: Colors.black,))),
              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Account Number",
                    hintStyle: TextStyle(color: Colors.black)),
                controller: accNumController,
                validator: validateAccNum,
                onChanged: (String val){
                  accNum = val;
                },
              ),
              SizedBox(
                height: 1.h,
              ),

              Align(alignment: Alignment.centerLeft,
                  child: Text("House Address", style: TextStyle(color: Colors.black,))),
              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "House Address",
                    hintStyle: TextStyle(color: Colors.black)),
                controller: addressController,
                validator: validateAddress,
                onChanged: (String val){
                  address = val;
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              loading ? ProgressBar():
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide.none)),
                  onPressed: () {
                    if(updateInfoFormKey.currentState!.validate()){
                        setState(() {
                          loading = true;
                        });
                        updateInfo();
                    }

                  },
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 2.h),
                    child: Text(
                      "Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  )),

            ],),
          ),
        ),
      ),
    );
  }

  void updateInfo() async {
     AuthRepo authRepo = AuthRepo();
     var token = await LocalStorage().fetch("token");
      print("printing token assssssssss${token.toString()}");
     try{
       Response? response = await authRepo.updateUserInfo({
         "jwt": token.toString(),
         "name": nameController.text,
         "tel": telController.text,
         "address": addressController.text,
         "email": emailController.text,
         "bankName" : bankNameController.text,
        "accountNumber" : accNumController.text,
       });

       print("nameeeeeeeee assssssssssss ${nameController.text}");

       if(response != null && response.statusCode == 200){

         showPopUp();

         setState((){
           success = response.data["message"];
         });
         successMsg();

       }else{
         setState((){
           resetPassErrorMssg = response?.data["message"];
         });

         desplayErromssge();
       }
     }catch(e){
       return;
     }
       loading = false;

  }

  void desplaySuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$successMssg",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );

  }

  void desplayErromssge() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$resetPassErrorMssg",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );

  }

  void getProfileDetails() async {

    dynamic userId = await LocalStorage().fetch("idKey");
    print("userid as $userId");

    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getSingleUserInfo({
        "id": userId.toString()
      });

      if(response != null && response.statusCode == 200){

        var  userdata = response.data;
        print("user data asssssssssss $userdata");

        setState(() {
          userName = userdata["name"];
        });
        print("usernameeeeeeeeeee as $userName");
        setState(() {
          email = userdata["email"];
        });
        setState(() {
          telNum = userdata["tel"];
        });
        setState(() {
          address = userdata["address"];
        });
        setState(() {
          bankName = userdata["bankName"];
        });
        setState(() {
          accNum = userdata["accountNumber"];
        });


      }else{

        print("could not retreive it");
      }

    }catch(e){

    }

  }

  void showPopUp() {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
            backgroundColor: Colors.black87,
            actions: <Widget>[SizedBox(height: 30,),
              Center(child: Icon(Icons.check_circle_outline,
                color: Colors.green, size: 35.sp,)),
              SizedBox(height: 20,),
               Center(
                child: Text(" Success!",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 30,),
               Center(
                child: Text(" Your Details was Updated",
                  style: TextStyle(
                      fontSize: 16.sp, color: Colors.white
                  ),
                ),
              ), SizedBox(height: 5,),
               Center(
                child: Text("Successfully",
                  style: TextStyle(
                      fontSize: 16.sp, color: Colors.white
                  ),
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                        Routers.pushNamed(context, '/dispatcher_landingPage_manager');
                   /*   Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return  DispatcherLandingPageManager(key: keyid,);
                      }));*/
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("OK", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      ),
                    )),
              ),
              SizedBox(height: 10,),

            ],
          ),
    );
  }


  Future<void> uploadImageToFirestore(File file) async {
    var imagePath = File(profileImage!.path);
    final firebaseStorage = FirebaseStorage.instance;

    if(profilePic != null){
      // uploadImageToServer();
      imageSnapshot = await firebaseStorage.ref(_firebaseAuth.currentUser?.uid).putFile(imagePath);

    }else{
      print("error image is empty");
    }

    downloadUrl = await (await imageSnapshot)?.ref.getDownloadURL();
    setState(() {
      imageLoading = false;
    });
    setState(() {

    });
   // showSuccess();
    upDateInfo();

  }

  Future<void> upDateInfo() async {
    return userCollection.doc(_firebaseAuth.currentUser?.uid).set({
      FirestoreConstants.photoUrl: downloadUrl,

    }, SetOptions(merge: true));

  }


  void desplayUploadSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$messageValue",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  void desplayError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$messageValue",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  void _getImage(BuildContext context) async {
    try{
      imagePickerManager.pickImage(
          context: context,
          file: (file){
            setState(() {
              profileImage = file;
            });

          });

    }catch(e){}

  }

  Future<void> uploadToApi({File? imageData}) async {

    var logedUserEmail = await LocalStorage().fetch("userData");
    var userEmail = logedUserEmail["email"];

    try{
      var request = http.MultipartRequest('POST',
          Uri.parse('https://nieveslogistics.com/api/php-api/profile_picture.php'));
          request.fields['email'] = userEmail;
      request.files.add(http.MultipartFile(
        'image',
        imageData!.readAsBytes().asStream(),
        imageData.lengthSync(),
        filename: imageData.path.split('/').last,
      ));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print("print res as......................$responseData");
        var decodedData = jsonDecode(responseData);

        var imageValue = decodedData["image"];

        setState(() {
          messageValue = decodedData["message"];
        });
        desplayUploadSuccess();
        setState(() {
          imageLoading = false;
        });

        // Process the response data as needed
      } else {
        // Handle non-200 status code
        desplayError();
        setState(() {
          imageLoading = false;
        });

      }
    }catch(e){
        print("error message is $e");
    }


  }

  void successMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 4),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$success",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  _formartFileImage(File? imageData) {
    if (imageData == null) return;
    return File(imageData.path.replaceAll('\'', '').replaceAll('File: ', ''));
  }

  void stopLoader() {}

}

