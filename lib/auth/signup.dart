import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sbs_prototype/auth/firebase_auth_implemention/firebase_auth_services.dart';
import 'package:sbs_prototype/models/user_model.dart';
import 'package:sbs_prototype/auth/signin.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/TextField.dart';
import 'package:sbs_prototype/widgets/Toast.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstname.dispose();
    _lastname.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirmpassword.dispose();
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
      /*appBar: AppBar(
        title: const Text(
          'SBS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Color(0xFF222831),
          ),
        ),
        backgroundColor: Color(0xFF76ABAE),
        centerTitle: true,
      ),*/
      backgroundColor: Color(0xFF222831),
      body: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          //children: [
          child: Center(
            child: Column(
              children: [
                // Sign Up
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFF76ABAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Sign Up

                // Create your account
                Container(
                  child: const Text(
                    'Create your account',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20.0,
                    ),
                  ),
                ),
                // Create your account

                // First name Field
                CustomTextField(
                  controller: _firstname,
                  hintText: 'First Name',
                  prefixIcon: Icon(Icons.person),
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  enabled: true,
                ),
                // First name Field

                // Last name Field
                CustomTextField(
                  controller: _lastname,
                  hintText: 'Last Name',
                  prefixIcon: Icon(Icons.person),
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  enabled: true,
                ),
                // Last name Field

                // Student Email Field
                CustomTextField(
                  controller: _email,
                  hintText: 'UOP Email',
                  prefixIcon: Icon(Icons.email),
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  enabled: true,
                  emailThings: true,
                ),
                // Student Email Field

                // Phone Field
                CustomTextField(
                  controller: _phone,
                  hintText: 'Phone',
                  prefixIcon: Icon(Icons.phone_iphone_outlined),
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  enabled: true,
                ),
                // Phone Field

                // Password Field
                CustomTextField(
                  controller: _password,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  keyboardType: null,
                  obscureText: true,
                  enabled: true,
                ),
                // Password Field

                // Confirm Password Field
                CustomTextField(
                  controller: _confirmpassword,
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(Icons.password),
                  keyboardType: null,
                  obscureText: true,
                  enabled: true,
                ),
                // Confirm Password Field

                // Sign Up Button
                CustomButton(
                  onPressed: () {
                    _signUp();
                  },
                  buttonText: 'Sign Up',
                  color: Color(0xFF76ABAE),
                ),
                // Sign Up Button

                //Already have an account? Login
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(
                            color: Color(0xFF76ABAE),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signin()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                //Already have an account? Login
              ],
            ),
          ),
          //],
        ),
      ),
    );
  }

  void _signUp() async {
    String firstname = _firstname.text;
    String lastname = _lastname.text;
    String email = '${_email.text}@uopstd.edu.jo';
    String phone = _phone.text;
    String password = _password.text;
    String confirmpassword = _confirmpassword.text;

    if (firstname.isEmpty ||
        lastname.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmpassword.isEmpty) {
      CustomToastMessage(message: "Please enter all fields");
    } else if (password != confirmpassword) {
      CustomToastMessage(message: "Passwords must be same");
    } else {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Signin()),
        );

        final storeUser = UserModel(
          firstName: firstname,
          lastName: lastname,
          email: email,
          phone: phone,
        );
        storeUser.createUser(storeUser);
        print("User is successfully created");
      } else {
        print("Some error happend");
      }
    }
  }
}
