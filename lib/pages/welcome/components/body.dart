import 'package:flutter/material.dart';
import 'package:toycathon/pages/Signup/signup_screen.dart';
import 'package:toycathon/pages/Welcome/components/background.dart';
import 'package:toycathon/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toycathon/pages/login/login_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "WELCOME TO TOYCATHON",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ElevatedButton(
                child: const Text(
                  "LOG IN",
                  style: TextStyle(color: kPrimaryLightColor),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    textStyle: const TextStyle(
                        color: kPrimaryLightColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                    ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: ElevatedButton(
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(color: kPrimaryLightColor),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()));
                },
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    textStyle: const TextStyle(
                        color: kPrimaryLightColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
