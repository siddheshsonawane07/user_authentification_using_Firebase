import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toycathon/components/google_sign_in_user_model.dart';

class LoginController with ChangeNotifier {
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;

  //function for google login

  googleLogin() async {
    this.googleSignInAccount = await _googleSignIn.signIn();

    //inserting values to our google sign in model

    userDetails = UserDetails(
      displayName: googleSignInAccount!.displayName,
      email: googleSignInAccount!.email,
    );

    //call
    notifyListeners();
  }

  logout() async {
    this.googleSignInAccount = await _googleSignIn.signOut();
    userDetails = null;
    notifyListeners();
  }
}
