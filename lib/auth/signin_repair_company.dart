import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbs_prototype/auth/firebase_auth_implemention/firebase_auth_services.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/TextField.dart';
import 'package:sbs_prototype/widgets/Toast.dart';

class SigninRepair extends StatefulWidget {
  const SigninRepair({super.key});

  @override
  State<SigninRepair> createState() => _SigninRepairState();
}

class _SigninRepairState extends State<SigninRepair> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SBS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Color(0xFF222831),
          ),
        ),
        backgroundColor: Color(0xFF76ABAE),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF76ABAE),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SustainableBookShare',
                style: TextStyle(
                  color: Color(0xFF222831),
                  fontSize: 25.0,
                ),
              ),
              Text(
                'Book and Notebook Exchange\nwith Repair Services',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Repair company's Sign In",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF222831),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CustomTextField(
                      controller: _email,
                      hintText: "Company's Email",
                      prefixIcon: Icon(FontAwesomeIcons.envelopeCircleCheck),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      enabled: true,
                      width: 330.0,
                      height: 55.0,
                      //emailThings: true,
                    ),
                    CustomTextField(
                      controller: _password,
                      hintText: 'Password',
                      prefixIcon: Icon(FontAwesomeIcons.lock),
                      keyboardType: null,
                      obscureText: true,
                      enabled: true,
                      width: 330.0,
                      height: 55.0,
                    ),
                    CustomButton(
                      onPressed: _signIn,
                      buttonText: 'Sign In',
                      color: Color(0xFF222831),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: _showForgotPasswordDialog,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signIn() async {
    String email = _email.text;
    String password = _password.text;

    if (email.isEmpty || password.isEmpty) {
      CustomToastMessage(message: "Please enter email or password");
    } else {
      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        await _auth.storeUserSignInStatus(true);
        Navigator.of(context).pushReplacementNamed('/repairhomepage');
        print("User is successfully signed in");
      } else {
        print("Some error happened");
      }
    }
  }

  void _showForgotPasswordDialog() {
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Color(0x00FFFEFE).withOpacity(0.9), // Set the dialog color
          title: Text(
            "Forgot Password",
            style: TextStyle(color: Color(0xFF222831)), // Set the title color
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextField(
                controller: emailController,
                hintText: "Email",
                prefixIcon: null,
                obscureText: false,
                enabled: true,
                keyboardType: TextInputType.emailAddress,
                emailThings: false,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // CustomButton for Cancel
                CustomButton(
                  onPressed: () => Navigator.pop(context),
                  color: Colors.red,
                  width: 130,
                  height: 40.0,
                  buttonText: 'Cancel',
                ),
                // CustomButton for Send
                CustomButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    if (email.isEmpty) {
                      CustomToastMessage(message: "Please enter your email");
                    } else {
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email);
                        Navigator.of(context).pop();
                        CustomToastMessage(
                            message: "Password reset email sent");
                      } on FirebaseAuthException catch (e) {
                        Navigator.of(context).pop();
                        CustomToastMessage(message: "Error: ${e.message}");
                      }
                    }
                  },
                  color: Color(0xFF76ABAE),
                  width: 130,
                  height: 40.0,
                  buttonText: 'Send',
                ),
              ],
            ),
          ],
        );
        /*    return AlertDialog(
          title: Text("Forgot Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Enter your email"),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Send"),
              onPressed: () async {
                String email = emailController.text.trim();
                if (email.isEmpty) {
                  CustomToastMessage(message: "Please enter your email");
                } else {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                    Navigator.of(context).pop();
                    CustomToastMessage(message: "Password reset email sent");
                  } on FirebaseAuthException catch (e) {
                    Navigator.of(context).pop();
                    CustomToastMessage(message: "Error: ${e.message}");
                  }
                }
              },
            ),
          ],
        ); */
      },
    );
  }
}
