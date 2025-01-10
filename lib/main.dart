import 'package:firebase_core/firebase_core.dart';
import 'package:flood_management_app/common/login_screen.dart';
import 'package:flood_management_app/common/registration_screen.dart';
import 'package:flood_management_app/common/splash_screen.dart';
import 'package:flood_management_app/modules/admin/admin_home.dart';
import 'package:flood_management_app/modules/camp/camp_home.dart';
import 'package:flood_management_app/modules/camp/camp_register_member.dart';
import 'package:flood_management_app/modules/camp/camp_request_commodities.dart';
import 'package:flood_management_app/modules/camp/camp_update_profile.dart';
import 'package:flood_management_app/modules/fmt/fmt_home.dart';
import 'package:flood_management_app/modules/qrt/qrt_home.dart';
import 'package:flood_management_app/modules/qrt/qrt_register_rescue.dart';
import 'package:flood_management_app/modules/qrt/qrt_view_camp.dart';
import 'package:flood_management_app/modules/qrt/qrt_view_requests.dart';
import 'package:flood_management_app/modules/user/user_home.dart';
import 'package:flood_management_app/modules/user/user_request_rescue.dart';
import 'package:flood_management_app/modules/fmt/fmt_register_camp.dart';
import 'package:flood_management_app/modules/fmt/fmt_register_qrt.dart';
import 'package:flood_management_app/modules/fmt/fmt_assign_request.dart';
import 'package:flood_management_app/modules/user/user_update_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCHS4e7Wtriz7fsdM3RQIXiRnhrmF061Zs",
        authDomain: "flood-mgmt.firebaseapp.com",
        projectId: "flood-mgmt",
        storageBucket: "flood-mgmt.firebasestorage.app",
        messagingSenderId: "813105501550",
        appId: "1:813105501550:web:a0aac51a614c4e02be1d7f",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Role Based Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),       // Splash screen route
        '/login': (context) => LoginScreen(),
        '/admin': (context) => const AdminHome(),
        '/fmt': (context) => const FMTHome(),
        '/qrt': (context) => const QRTHome(),
        '/user': (context) => const UserHome(),
        '/camp': (context) => const CampHome(),
        '/registration': (context) => RegistrationScreen(),
        '/fmt_register_camp': (context) =>  const FMTRegisterCamp(),
        '/fmt_register_qrt': (context) => const FMTRegisterQRT (),   
        '/fmt_assign_request': (context) => const FMTAssignRequest(), 
        '/qrt_register_rescue':(context) => const QRTRegisterRescue(),
        '/qrt_view_camp': (context) => QRTViewCamp(),
        '/qrt_view_requests':(context) => QRTViewRequests(),
        '/user_request_rescue':(context) => const UserRequestRescue(),
        '/user_update_profile':(context) => const UserUpdateProfile(),
        '/camp_register_member':(context) => const CampRegisterMember(),
        '/camp_request_commodities':(context) => const CampRequestCommodities(),
        '/camp_update_profile':(context) => const CampUpdateProfile(),
      },
    );
  }
}
