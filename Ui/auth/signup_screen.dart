import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FirebasePractice/Ui/auth/login_Screen.dart';
import 'package:FirebasePractice/Utils/Utils.dart';
import 'package:FirebasePractice/widgets/roundbutton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void signup(){
    setState(() {
      loading= true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
      setState(() {
        loading= false;
      });
    }).onError((error, stackTrace) {
      Utils().toastmessage(error.toString());
      setState(() {
        loading= false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(children:[
          SizedBox(width: 80,),
          Text("Sign Up")
        ]
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: 'email',
                        prefixIcon: Icon(Icons.email_outlined)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter email';
                      } return null;
                    },
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_open)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter password';
                      } return null;
                    },
                  ),

                ],
              ),),
            const SizedBox(height: 20,),
            Roundbutton(
              title: 'Sign Up',
              loading: loading,
              onTap: (){
                if(_formkey.currentState!.validate()){
                  signup();
                  Utils().toastmessage("Sign up success please login ");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                }
              },
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already  have a account ? "),
                const SizedBox(width: 5,),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                }, child: const Text("Log in"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
