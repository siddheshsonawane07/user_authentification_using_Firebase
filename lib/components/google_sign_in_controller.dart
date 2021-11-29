import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController with ChangeNotifier {
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  login() async {
    this.googleSignInAccount = await _googleSignIn.signIn();

    //call
    notifyListeners();
  }

  logout() async {
    //empty the value after logout

    this.googleSignInAccount = await _googleSignIn.signOut();
  }
}
