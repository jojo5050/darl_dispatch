
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/Models/fb_custom_user.dart';
import 'package:darl_dispatch/Models/firestore_constants.dart';
import 'package:darl_dispatch/Models/global_variables.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../ConstantHelper/colors.dart';
import '../../Utils/form_validators.dart';
import '../../Utils/progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with FormValidators {

  TextEditingController userRegFullNameController = TextEditingController();
  TextEditingController userRegEmailController = TextEditingController();
  TextEditingController userRegPhoneNumController = TextEditingController();
  TextEditingController userRegPasswordController = TextEditingController();
  TextEditingController userRegConfirmPassController = TextEditingController();
  final GlobalKey<FormState> userRegFormKey = GlobalKey<FormState>();

  bool loading = false;
  bool _passwordVisible =false;

  String initialCountry = "NG";
  PhoneNumber phoneNum = PhoneNumber(isoCode: "NG");
 // CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");
  var errorMessage;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");

  FirebaseAuthException? msg;

  TaskSnapshot? imageSnapshot;

  String? downloadUrl;

  User? firebaseUser;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
           Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors:
              [Colors.lightBlueAccent, Colors.greenAccent],
                  begin: Alignment.centerLeft, end: Alignment.centerRight),)
            ),
            SingleChildScrollView(
              child: Form(
                key: userRegFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          IconButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.black,))

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Enter your details to create an account",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                          controller: userRegFullNameController,
                          validator: validateFullName,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 20,
                            ),
                            fillColor: AppColors.textFieldColor,
                            filled: true,
                            hintText: "Full name",
                            hintStyle: const TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                          controller: userRegEmailController,
                          validator: validateEmail,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                              size: 20,
                            ),
                            fillColor: AppColors.textFieldColor,
                            filled: true,
                            hintText: "Email",
                            hintStyle: const TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 10.w),
                     child: Container(
                       height: 75,
                       width: MediaQuery.of(context).size.width / 0.7,
                     decoration: BoxDecoration(
                       border: Border.all(width: 1, color: Colors.grey),
                         color: AppColors.textFieldColor,
                         borderRadius: BorderRadius.circular(15)),

                       child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: 5.w),
                         child: InternationalPhoneNumberInput(
                           inputDecoration: const InputDecoration(
                             border: InputBorder.none,
                             hintText: "Phone",
                             hintStyle: TextStyle(color: Colors.black),
                             enabledBorder: InputBorder.none,

                           ),
                             textFieldController: userRegPhoneNumController,
                             formatInput: true,
                             initialValue: phoneNum,
                             selectorConfig: const SelectorConfig(selectorType:
                             PhoneInputSelectorType.BOTTOM_SHEET),
                             keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                             onInputChanged: (PhoneNumber phoneNum){

                             },),
                       ),
                     ),
                   ),

                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                          controller: userRegPasswordController,
                          validator: validatePassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: IconButton(icon: Icon(_passwordVisible ? Icons.visibility
                                : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                              size: 20,
                            ),
                            fillColor: AppColors.textFieldColor,
                            filled: true,
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Text(
                      "Minimum of 8 characters" ,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                          controller: userRegConfirmPassController,
                          validator: confirmPassValidator,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: IconButton(icon: Icon(_passwordVisible ? Icons.visibility
                                : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                              size: 20,
                            ),
                            fillColor: AppColors.textFieldColor,
                            filled: true,
                            hintText: "Confirm Password",
                            hintStyle: const TextStyle(color: Colors.black)),
                      ),
                    ),

                    SizedBox(
                      height: 4.h,
                    ),
                  //  loading ? ProgressBar():
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide.none)),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if(userRegFormKey.currentState!.validate()){
                                startLoader();
                                signUp();
                          }
                        },

                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 28.w, vertical: 2.h),
                          child: Text(
                            "Create",
                            style: TextStyle(color: Colors.white, fontSize: 17.sp),
                          ),
                        )),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        TextButton(
                            onPressed: () {
                              Routers.pushNamed(context, '/login_page');
                            },
                            child: Text(
                              "LOG IN",
                              style: TextStyle(color: Colors.blue,
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ))
                        //   Text("SIGN UP", style: TextStyle(color: Colors.blue, fontSize: 15.sp),)
                      ],
                    )
                  ],
                ),
              ),
        ),
        ],
      ),
    );
  }

  String? confirmPassValidator(String? value) {

    if(value != userRegPasswordController.text){
      return "Password did not match";
    }
    return null;
  }

  void signUp() async {
    final AuthRepo authRepo = AuthRepo();
     try{
        Response? response = await authRepo.register({
          "name": userRegFullNameController.text,
          "email": userRegEmailController.text,
          "tel": userRegPhoneNumController.text,
          "role": "Staff",
          "password": userRegPasswordController.text,
          "cpassword": userRegConfirmPassController.text,
          "status": "1"
        });

        if(response != null && response.statusCode == 200 && response.data["status"] == "success" ){
          regWithEmailAndPassword(userRegEmailController.text, userRegPasswordController.text);

          desplaySignupsuccessmssg();
          stopLoading();
          Routers.replaceAllWithName(context, '/login_page');

        }
         if (response != null && response.statusCode == 200 && response.data["status"] == 400){
          setState(() {
            errorMessage = response.data["message"];
          });
          displayErrorSnackbar();
          stopLoading();

        } else if(response == null) {
           displayServerError();
           stopLoading();
         }


     }catch(e, str){
       debugPrint("Error: $e");
       debugPrint("StackTrace: $str");
     }
     userFullName = userRegFullNameController.text;
  }

  void  displayErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "$errorMessage",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  Future desplaySignupsuccessmssg() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "Registration was Successful",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Future<void> startLoader() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: const Center(child: ProgressBar(),),
        );
      },
    );

  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }

  void displayServerError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "Server not reachable, try again",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Future regWithEmailAndPassword(

      String email, String password) async {
    print("print here ......................... first");
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password,
      );

      if(userCredential.user != null ){
        CustomUser customUser = CustomUser(
          firebaseUser: userCredential.user,
          trackingId: null,
        );

        uploadDefaultProfilePicture();

        await userCollection.doc(customUser.firebaseUser!.uid).set({
          FirestoreConstants.name: userRegFullNameController.text,
          FirestoreConstants.id: customUser.firebaseUser!.uid,
          FirestoreConstants.chattingWith: null,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),

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
  Future<void> uploadDefaultProfilePicture() async {
    final firebaseStorage = FirebaseStorage.instance;
    final defaultImageAssetPath = 'assets/images/profileavater.png';

    // Load the default image from assets
    ByteData imageData = await rootBundle.load(defaultImageAssetPath);
    Uint8List bytes = imageData.buffer.asUint8List();

    // Save the default image to a temporary file
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/profileavater.png';
    File tempFile = File(tempPath);
    await tempFile.writeAsBytes(bytes);

    // Upload the default image to Firebase Storage
    try {
      await firebaseStorage.ref('profileavater.png').putFile(tempFile);
      print('Default profile picture uploaded successfully');

      String downloadUrl = await firebaseStorage
          .ref('profileavater.png')
          .getDownloadURL();

      String userId = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');
      await usersCollection.doc(userId).update({
        'photoUrl': downloadUrl,
      });
    } catch (e) {
      print('Error uploading default profile picture: $e');
    }

    // Delete the temporary file
    await tempFile.delete();
  }

}