import 'package:flutter/material.dart';
import 'package:FirebasePractice/firebase_s/splash_s.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Splashs splashScreen= Splashs();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      splashScreen.isLogin(context);
    } catch (e) {
      print('Error in SplashScreen: $e');
    }

  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Forum Ias',style: TextStyle(color: Colors.blue,fontSize: 30),),
      ),
    );
  }
}
