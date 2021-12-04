// ignore_for_file: avoid_print, unnecessary_new, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toycathon/constants.dart';
import 'package:toycathon/pages/login/components/background.dart';
import 'package:toycathon/pages/main/dashboard.dart';
import 'package:toycathon/pages/signup/signup_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreen createState() => _ResetScreen();
}

class _ResetScreen extends State<ResetScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  // ignore: unnecessary_new
  // final TextEditingController passwordController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      cursorColor: kPrimaryColor,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.email,
          color: kPrimaryColor,
        ),
        hintText: "Your Email",
        border: InputBorder.none,
      ),
    );

    // ignore: non_constant_identifier_names
    final Send_Request = TextButton(
      onPressed: () {
        reset(emailController.text);
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Email sent");
      },
      child: const Text(
        "Send Request",
        style: TextStyle(
            color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              const Text(
                "FORGOT PASSWORD",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      emailField,
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Send_Request,
              SizedBox(height: size.height * 0.02),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: ElevatedButton(
                  child: const Text(
                    "Don't have an account ? SIGNUP",
                    style: TextStyle(fontSize: 12, color: kPrimaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    CheckUserLog();
  }

  void CheckUserLog() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }
  }

  void reset(String _email) {
    _auth.sendPasswordResetEmail(email: _email);
  }
}
