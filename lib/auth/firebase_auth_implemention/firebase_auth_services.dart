import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sbs_prototype/widgets/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      CustomToastMessage(message: 'Email is already Signed Up');
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error ");
    }
    return null;
  }

  Future<void> storeUserSignInStatus(bool isSignedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', isSignedIn);
  }

  Future<bool> getUserSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isSignedIn') ?? false;
  }

  Future<void> checkCurrentUser(BuildContext context) async {
    bool isSignedIn = await getUserSignInStatus();
    if (isSignedIn) {
      User? user = _auth.currentUser;
      if (user?.email.toString() == "amerwwww360@gmail.com") {
        Navigator.pushReplacementNamed(context, '/repairhomepage');
      } else if (user != null) {
        Navigator.pushReplacementNamed(context, '/homepage');
      } else {
        Navigator.pushReplacementNamed(context, '/signin');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await storeUserSignInStatus(false);
      Navigator.pushReplacementNamed(context, '/signin');
    } catch (e) {
      CustomToastMessage(message: 'Error signing out: $e');
    }
  }

  // Method to send a password reset email
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Handle errors here
      print("Error sending reset password email: $e");
      throw e;
    }
  }
}
