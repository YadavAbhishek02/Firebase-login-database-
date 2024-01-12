import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:FirebasePractice/Ui/auth/Login_with_Phone.dart';
import 'package:FirebasePractice/Ui/auth/signup_screen.dart';
import 'package:FirebasePractice/Ui/forgotPassword.dart';
import 'package:FirebasePractice/Ui/posts/post_screen.dart';
import 'package:FirebasePractice/Utils/Utils.dart';
import 'package:FirebasePractice/widgets/roundbutton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }
  void login(){
    setState(() {
      loading= true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value){
        Utils().toastmessage(value.user!.email.toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>const Postscreen()));
        setState(() {
          loading= false;
        });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastmessage(error.toString());
      setState(() {
        loading= false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
    },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text("Login")),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: 'email',
                        prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter email';
                      } return null;
                    },
                  ),
                 const  SizedBox(height: 20,),

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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPassword()));
                    }, child:const Text("Forgot password ")),
                  ),
                ],
              ),),
             const SizedBox(height: 20,),
             Roundbutton(
                 title: 'Login',
                 loading: loading,
                 onTap: (){
                   if(formKey.currentState!.validate()){
                     login();
                   }
                 },
             ),
             const  SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont have a account ? "),
                 const SizedBox(width: 10,),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                  }, child: const Text("Sign up"))
                ],
              ),
             const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Loginwithphone()));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black,
                    )
                  ),
                  child: const Center(child: Text("Log in with Phone number")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
