import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FirebasePractice/Ui/auth/login_Screen.dart';
import 'package:FirebasePractice/Utils/Utils.dart';
import 'package:FirebasePractice/widgets/roundbutton.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Roundbutton(title: 'Forgot', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
               auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
               Utils().toastmessage("We have sent you email to recover your password");
               }).onError((error, stackTrace) {
              Utils().toastmessage(error.toString());
               });
            }),
          )
        ],
      ),
    );
  }
}
