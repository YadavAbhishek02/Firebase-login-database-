import 'dart:async';
import 'dart:io';
import 'package:FirebasePractice/rest_api/login_signup.dart';
import 'package:FirebasePractice/search_student_viewcontroller.dart';
import 'package:FirebasePractice/start_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CompreshensiveViewController.dart';
import 'Networkconnection/NetworkingCheck.dart';
import 'Networkconnection/NoInternetViewController.dart';
import 'SubmitDailogBox.dart';
import 'Ui/splash_screen.dart';
import 'mentroship.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Platform.isAndroid?
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyCH2kDXWUibPJPylf57DxVGrId4_DoQ5UA",
//       appId: "1:818040177884:android:e7a7c352d8815ba0b6e019",
//       messagingSenderId: "818040177884",
//       projectId: "chatting-ebddf",
//     ),
//   )
//   :await Firebase.initializeApp();
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey:'AIzaSyCH2kDXWUibPJPylf57DxVGrId4_DoQ5UA',
      appId:'1:818040177884:android:e7a7c352d8815ba0b6e019',
      messagingSenderId:'818040177884',
      projectId:'chatting-ebddf'));
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      debugShowCheckedModeBanner: false,
      home:   const SplashScreen(),//const MyHomePage(),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   SplashScreenState createState() => SplashScreenState();
// }
// class SplashScreenState extends State<MyHomePage> {
//   @override
//   void initState() {
//     checkLoginStatus();
//     super.initState();
//
//   }
//   void checkLoginStatus() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     String? token = sp.getString('token');
//
//     if (token != null) {
//       // User is already logged in
//
//       Timer(const Duration(seconds: 5),
//               ()=>Navigator.pushReplacement(context,
//               MaterialPageRoute(builder:
//                   (context) => const ComprehensiveViewController()
//               )
//           )
//       );
//     } else {
//       //User is not logged in
//       Timer(const Duration(seconds: 3),
//               ()=>Navigator.pushReplacement(context,
//               MaterialPageRoute(builder:
//                   (context) => const ApiSignUpScreen()
//               )
//           )
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.white,
//       body:  Center(child: Text('Forum Ias',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w900),),),
//     );
//
//   }
// }
