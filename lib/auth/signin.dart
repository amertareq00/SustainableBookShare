/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbs_prototype/auth/firebase_auth_implemention/firebase_auth_services.dart';
import 'package:sbs_prototype/auth/signup.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/TextField.dart';
import 'package:sbs_prototype/widgets/Toast.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  //
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
    return WillPopScope(
      child: Scaffold(
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
        backgroundColor: Color(0xFF222831),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SustainableBookShare
                Text(
                  'SustainableBookShare',
                  //textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xFF76ABAE),
                    fontSize: 25.0,
                  ),
                ),
                // SustainableBookShare

                // Book and Notebook Exchange with Repair Services
                Text(
                  'Book and Notebook Exchange\nwith Repair Services',
                  //textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20.0,
                  ),
                ),
                // Book and Notebook Exchange with Repair Services

                Container(
                  height: 50,
                ),
                ////////////////////////////the field at the center///////////////////////////////////
                Center(
                  child: Column(
                    children: [
                      //Sign In
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF76ABAE),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //Sign In

                      // Student Email Field
                      CustomTextField(
                        controller: _email,
                        hintText: 'Student Email',
                        prefixIcon: Icon(FontAwesomeIcons.envelopeCircleCheck),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        enabled: true,
                      ),
                      // Student Email Field

                      // Password Field
                      CustomTextField(
                        controller: _password,
                        hintText: 'Password',
                        prefixIcon: Icon(FontAwesomeIcons.lock),
                        keyboardType: null,
                        obscureText: true,
                        enabled: true,
                      ),
                      // Password Field

                      // Sign In Button
                      CustomButton(
                        onPressed: () {
                          _signIn();
                        },
                        buttonText: 'Sign In',
                        color: Color(0xFF76ABAE),
                      ),
                      // Sign In Button

                      Container(
                        height: 30,
                      ),

                      // Forgot Password?
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Forgot Password?
                      Text(
                        'or',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      //Don't have an account? Sign Up
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF76ABAE),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Don't have an account? Sign Up
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onWillPop: () async => false,
    );
  }

  void _signIn() async {
    String email = _email.text;
    String password = _password.text;

    if (email.isEmpty || password.isEmpty) {
      CustomToastMessage(message: "Please enter email or password");
    } else if (!RegExp("^[0-9]{9}@[uopstd.edu]+.[jo]").hasMatch(email)) {
      CustomToastMessage(message: "Please enter a valid email");
    } else {
      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        await _auth.storeUserSignInStatus(true);
        Navigator.of(context).pushReplacementNamed('/homepage');

        print("User is successfully signed in ]]]]]]]]]]]");
      } else {
        print("Some error happend");
      }
    }
  }
}
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbs_prototype/auth/firebase_auth_implemention/firebase_auth_services.dart';
import 'package:sbs_prototype/auth/signup.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/TextField.dart';
import 'package:sbs_prototype/widgets/Toast.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
        backgroundColor: Color(0xFF222831),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SustainableBookShare',
                  style: TextStyle(
                    color: Color(0xFF76ABAE),
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
                          'Sign In',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF76ABAE),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomTextField(
                        controller: _email,
                        hintText: 'UOP Email',
                        prefixIcon: Icon(FontAwesomeIcons.envelopeCircleCheck),
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        enabled: true,
                        emailThings: true,
                      ),
                      CustomTextField(
                        controller: _password,
                        hintText: 'Password',
                        prefixIcon: Icon(FontAwesomeIcons.lock),
                        keyboardType: null,
                        obscureText: true,
                        enabled: true,
                      ),
                      CustomButton(
                        onPressed: _signIn,
                        buttonText: 'Sign In',
                        color: Color(0xFF76ABAE),
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
                      Text(
                        'or',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF76ABAE),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/repairsignin');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Are you a repair company?',
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
      ),
    );
  }

  void _signIn() async {
    String email = '${_email.text}@uopstd.edu.jo';
    String password = _password.text;

    if (email.isEmpty || password.isEmpty) {
      CustomToastMessage(message: "Please enter email or password");
    } else {
      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        await _auth.storeUserSignInStatus(true);
        Navigator.of(context).pushReplacementNamed('/homepage');
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
                hintText: "UOP Email",
                prefixIcon: null,
                obscureText: false,
                enabled: true,
                keyboardType: TextInputType.emailAddress,
                emailThings: true,
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
                    email = '$email@uopstd.edu.jo';

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

        /* return AlertDialog(
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
