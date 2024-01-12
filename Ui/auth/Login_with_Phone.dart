import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FirebasePractice/Ui/auth/VerifyCode.dart';
import 'package:FirebasePractice/Utils/Utils.dart';
import 'package:FirebasePractice/widgets/roundbutton.dart';

class Loginwithphone extends StatefulWidget {
  const Loginwithphone({super.key});

  @override
  State<Loginwithphone> createState() => _LoginwithphoneState();
}

class _LoginwithphoneState extends State<Loginwithphone> {
  bool loading =false;
  final phoneNumberController = TextEditingController();
  final auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20,),
             TextFormField(
              controller: phoneNumberController,
              decoration:const  InputDecoration(
                hintText: '+91 234 234 234'
              ),
            ),
           const  SizedBox(height: 50,),
            Roundbutton(title: "Login",loading: loading, onTap: (){
              setState(() {
                loading=true;
              });
          auth.verifyPhoneNumber(
              phoneNumber: phoneNumberController.text,
              verificationCompleted: (_){
                setState(() {
                  loading=false;
                });
              },
              verificationFailed: (e){
                Utils().toastmessage(e.toString());
              },
              codeSent: (String verificationId, int ? token){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCode(verificationId: verificationId,)));
                setState(() {
                  loading=false;
                });
              },
              codeAutoRetrievalTimeout:(e){
                Utils().toastmessage(e.toString());
                setState(() {
                  loading=false;
                });
              });
            })
          ],
        ),
      ),
    );
  }
}
