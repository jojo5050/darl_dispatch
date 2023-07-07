import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/Drivers/driver_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'Chat/chat_list_provider.dart';
import 'Chat/chat_provider.dart';
import 'ConstantHelper/colors.dart';
import 'GoogleMapManagers/location_provider.dart';
import 'Onboaarding/splash_screen.dart';
import 'Providers/auth_provider.dart';
import 'Utils/routes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // late final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider()),

        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            //  prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        Provider<ChatListProvider>(
          create: (_) => ChatListProvider(
            //  prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
          ),
        ),
        ChangeNotifierProvider<LocationProvider>(
          create: (context) => LocationProvider(
          ),
          child: DriverProfilePage(),
        ),

      ],
      child: MaterialApp(
        title: "Darl Dispatch",
        theme: ThemeData(
          fontFamily: 'Interfont',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primary,
          ),
        ),

        home: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return const SplashScreen();
          },
        ),
        onGenerateRoute: generateRoute,
      ),
    );
  }

}
