
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/LandingPageManagers/admin_landing_page_manager.dart';
import 'package:darl_dispatch/Utils/localstorage.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../ConstantHelper/colors.dart';
import '../../Models/fb_auth_model.dart';
import '../../Utils/form_validators.dart';
import '../../Utils/progress_bar.dart';
import 'fb_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with FormValidators {

  TextEditingController userLoginEmailController = TextEditingController();
  TextEditingController userLoginPasswordController = TextEditingController();
  final GlobalKey<FormState> userLoginFormKey = GlobalKey<FormState>();
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;
  bool _passwordVisible =false;

  var errorMessage;
  final FbAuthService fbAuthService = FbAuthService();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var errorMsg;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopControll,
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors:
              [Colors.white, Colors.indigo],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter),),
          ),
          SingleChildScrollView(
            child: Form(
              key: userLoginFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 7.h,
                  ),

                  Text(
                    "Login",
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
                    "Welcome Back",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontSize: 18.sp),
                      controller: userLoginEmailController,
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
                    height: 3.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TextFormField(
                      obscureText: !_passwordVisible,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontSize: 18.sp),
                      controller: userLoginPasswordController,
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
                  SizedBox(
                    height: 1.h,
                  ),
                  TextButton(onPressed: (){
                    Routers.pushNamed(context, '/forgotPassEmail');
                  },
                      child: Text("Forgot password?",
                        style: TextStyle(color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),)),
                  SizedBox(
                    height: 7.h,
                  ),

                //  loading ? ProgressBar():
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide.none)),
                      onPressed: () {

                        if(userLoginFormKey.currentState!.validate()){
                          startLoader();
                          signin();
                         // showLoader();
                        }
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 2.h),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 17.sp),
                        ),
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      TextButton(
                          onPressed: () {
                            Routers.pushNamed(context, '/sign_up_page');
                          },
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.green, fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ))
                      //   Text("SIGN UP", style: TextStyle(color: Colors.blue, fontSize: 15.sp),)
                    ],
                  ), Text("OR", style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 18.sp),),
                  SizedBox(
                    width: 2.w,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Container(height: 10.h, width: 15.w,
                    decoration: const BoxDecoration(image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/googleImage.png'),
                    ), shape: BoxShape.circle),),
                      TextButton(onPressed: (){

                        signInWithGoogle(context);
                             }, child: const Text('Sign in with Google',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),)

                      )],)
                ],
              ),
            ),
          ),


        ])
      ),
    );
  }

  void signin() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.login({
        "email": userLoginEmailController.text,
        "password": userLoginPasswordController.text
      });

      if(response != null && response.statusCode == 200 && response.data["success"] == 200
          && response.data["user-info"]["role"] == "Staff"){
        desplayLoginsuccessmssg();
        await LocalStorage().store("userData", response.data["user-info"]);
        await LocalStorage().store("token", response.data["data"]["token"]);
        await LocalStorage().store("roleKey", response.data["user-info"]["role"]);
        await LocalStorage().store("idKey", response.data["user-info"]["id"]);

        loginToFirebase(userLoginEmailController.text, userLoginPasswordController.text);
        Routers.replaceAllWithName(context, '/initial_dashboard');
      }

      if(response != null && response.statusCode == 200 && response.data["success"] == 200
          && response.data["user-info"]["role"] == "Accountant"){
        desplayLoginsuccessmssg();
        await LocalStorage().store("userData", response.data["user-info"]);
        await LocalStorage().store("token", response.data["data"]["token"]);
        await LocalStorage().store("roleKey", response.data["user-info"]["role"]);
        await LocalStorage().store("idKey", response.data["user-info"]["id"]);

        loginToFirebase(userLoginEmailController.text, userLoginPasswordController.text);
        Routers.replaceAllWithName(context, '/accountant_landing_manager');
      }

      if(response != null && response.statusCode == 200 && response.data["success"] == 200
          && response.data["user-info"]["role"] == "Admin"){
        desplayLoginsuccessmssg();
        await LocalStorage().store("userData", response.data["user-info"]);
        await LocalStorage().store("token", response.data["data"]["token"]);
        await LocalStorage().store("roleKey", response.data["user-info"]["role"]);
        await LocalStorage().store("idKey", response.data["user-info"]["id"]);

        loginToFirebase(userLoginEmailController.text, userLoginPasswordController.text);
        Routers.replaceAllWithName(context, '/admin_landing_manager');
      }

      if(response != null && response.statusCode == 200 && response.data["success"] == 200
          && response.data["user-info"]["role"] == "Despatcher"){
        desplayLoginsuccessmssg();
        await LocalStorage().store("userData", response.data["user-info"]);
        await LocalStorage().store("token", response.data["data"]["token"]);
        await LocalStorage().store("roleKey", response.data["user-info"]["role"]);
        await LocalStorage().store("idKey", response.data["user-info"]["id"]);

        loginToFirebase(userLoginEmailController.text, userLoginPasswordController.text);
        Routers.replaceAllWithName(context, '/dispatcher_landingPage_manager');
      }

      if(response != null && response.statusCode == 200 && response.data["success"] == 200
          && response.data["user-info"]["role"] == "Driver"){
        desplayLoginsuccessmssg();
        await LocalStorage().store("userData", response.data["user-info"]);
        await LocalStorage().store("token", response.data["data"]["token"]);
        await LocalStorage().store("roleKey", response.data["user-info"]["role"]);
        await LocalStorage().store("idKey", response.data["user-info"]["id"]);

        loginToFirebase(userLoginEmailController.text, userLoginPasswordController.text);
        Routers.replaceAllWithName(context, '/driver_landing_manager');
      }
       else if(response != null && response.statusCode == 200
          && response.data["status"] == "error"){
          setState(() {
            errorMessage = response.data["message"];
          });
          displayError();
          stopLoader();
      }
       else if(response != null && response.statusCode == 200
          && response.data["success"] == 0){

        setState(() {
          errorMsg = response.data["message"];
        });
        displayErrMsg();
         stopLoader();
       }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }
  }

  Future desplayLoginsuccessmssg() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "Login Successful",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  void displayError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "$errorMessage",
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

  Future<void> stopLoader() async {
    Navigator.of(context).pop();
  }

  void displayErrMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "$errorMsg",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Future loginToFirebase(
      String email, String password) async {
    try {
      User? firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).user;
      if(firebaseUser != null){
        await usersRef.doc(firebaseAuth.currentUser!.uid).update({
          "status": "Online"
        });

        return firebaseAuth.currentUser?.uid;
      }

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

  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  Future<bool> willPopControll() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //  title: new Text('Are you sure?'),
        content: new Text('Do you want to exit the App'),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => exitApp(),
                child: new Text('Yes'),
              ),
            ],
          ),
        ],
      ),
    )) ??
        false;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      var idtk = googleSignInAuthentication.idToken;
      var acctk = googleSignInAuthentication.accessToken;
      print("print id token as $idtk");
      print("print access token as $acctk");
      
      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminLandingPageManager()));
      }  // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }


}
