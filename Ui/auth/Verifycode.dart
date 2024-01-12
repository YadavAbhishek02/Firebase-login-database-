import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:FirebasePractice/Ui/posts/post_screen.dart';
import 'package:FirebasePractice/Utils/Utils.dart';
import 'package:FirebasePractice/widgets/roundbutton.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class VerifyCode extends StatefulWidget {
  final String verificationId;

  const VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading = false;
  late TextEditingController textEditingController1;
  final auth = FirebaseAuth.instance;
  String _comingSms = 'Unknown';

  // Future<void> initSmsListener() async {
  //
  //   String? comingSms;
  //   try {
  //     comingSms = await AltSmsAutofill().listenForSms;
  //   } on PlatformException {
  //     comingSms = 'Failed to get Sms.';
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _comingSms = comingSms!;
  //     print("====>Message: $_comingSms");
  //     print(_comingSms[0]);
  //     textEditingController1.text = _comingSms[0] + _comingSms[1] + _comingSms[2] + _comingSms[3]
  //         + _comingSms[4] + _comingSms[5]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
  //   });
  // }

  Future<void> initSmsListener() async {
    String? comingSms;

    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }

    if (!mounted) return;

    setState(() {
      _comingSms = comingSms!;
      print("====>Message: $_comingSms");

      // Use a regular expression to extract the OTP from the message
      RegExp regExp = RegExp(r'(\b\d{6}\b)');
      Match? match = regExp.firstMatch(_comingSms);

      if (match != null) {
        // Extracted OTP
        String otp = match.group(0)!;
        print("Extracted OTP: $otp");

        // Set the OTP to the TextEditingController
        textEditingController1.text = otp;
      } else {
        // Handle case where OTP is not found
        print("OTP not found in the message.");
      }
    });
  }

  @override
  void initState() {
    super.initState();
      textEditingController1 = TextEditingController();
     initSmsListener();
  }

  @override
  void dispose() {
   // controller.stopListen();
    textEditingController1.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // TextField(
            //   textAlign: TextAlign.center,
            //   keyboardType: TextInputType.number,
            //   controller: controller,
            //   decoration: const InputDecoration(
            //     labelText: 'enter otp',
            //   ),
            // ),
            PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveFillColor: Colors.white,

                  selectedFillColor: Colors.white,
                  activeFillColor: Colors.white,

              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: textEditingController1,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
                //do something or move to next screen when code complete
              },
              onChanged: (value) {
                print(value);
                setState(() {
                  print(value);
                });
              },
            ),
            const SizedBox(height: 50),
            Roundbutton(
              title: "Verify",
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: textEditingController1.text.toString(),
                  );

                  try {
                    await auth.signInWithCredential(credential);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Postscreen()),
                    );
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastmessage("Verification failed: $e");
                  }
              },
            ),

          ],
        ),
      ),
    );
  }
}