// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:toycathon/components/user_model.dart';
import 'package:toycathon/constants.dart';
import 'package:toycathon/pages/login/components/body.dart';
import 'package:toycathon/pages/login/login_screen.dart';
import 'package:toycathon/pages/signup/components/background.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  final firstNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final otpcontroller = new TextEditingController();
  EmailAuth emailAuth = new EmailAuth(sessionName: "Test session");

  @override
  void initState() {
    super.initState();
  }

  void sendOTP() async {
    var res =
        await emailAuth.sendOtp(recipientMail: emailEditingController.text);
    if (res) {
      print("OTP Sent");
    } else {
      print("Error in sending OTP");
    }
  }

  void verifyOTP() {
    var res = emailAuth.validateOtp(
        recipientMail: emailEditingController.text,
        userOtp: otpcontroller.text);
    if (res) {
      print("OTP Verified");
    } else {
      print("Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: kPrimaryColor,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.person,
          color: kPrimaryColor,
        ),
        hintText: "Name",
        border: InputBorder.none,
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
          icon: const Icon(
            Icons.email,
            color: kPrimaryColor,
          ),
          hintText: "Email",
          border: InputBorder.none,
          suffixIcon: TextButton(
              child: const Text(
                "Send OTP",
                style: TextStyle(color: kPrimaryColor, fontSize: 8),
              ),
              onPressed: () {
                sendOTP();
                Fluttertoast.showToast(msg: "OTP Sent");
              })),
    );

    final otp = TextFormField(
      autofocus: false,
      controller: otpcontroller,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter OTP");
        }
        return null;
      },
      onSaved: (value) {
        otpcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
          icon: const Icon(
            Icons.email,
            color: kPrimaryColor,
          ),
          hintText: "OTP",
          border: InputBorder.none,
          suffixIcon: TextButton(
              child: const Text(
                "Verify OTP",
                style: TextStyle(color: kPrimaryColor, fontSize: 8),
              ),
              onPressed: () {
                verifyOTP();
                Fluttertoast.showToast(msg: "OTP Verified");
              })),
    );

    final passwordfield = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        // ignore: unnecessary_new
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: kPrimaryColor,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.lock,
          color: kPrimaryColor,
        ),
        hintText: "Password",
        border: InputBorder.none,
      ),
    );

    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          hintText: "Confirm Password",
          border: InputBorder.none,
        ));

    final signUpButton = ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: ElevatedButton(
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          "SIGN UP",
          style: TextStyle(
              color: kPrimaryLightColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          textStyle: const TextStyle(
              color: kPrimaryLightColor,
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
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
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      firstNameField,
                      emailField,
                      otp,
                      passwordfield,
                      confirmPasswordField,
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              signUpButton,
              SizedBox(height: size.height * 0.01),
              ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(
                  child: const Text(
                    'Already have a account ? LOGIN',
                    style: TextStyle(fontSize: 12, color: kPrimaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        // ignore: avoid_print
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }
}
