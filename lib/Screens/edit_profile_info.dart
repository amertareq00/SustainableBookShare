import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbs_prototype/models/user_model.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/EndDrawer.dart';
import 'package:sbs_prototype/widgets/TextField.dart';
import 'package:sbs_prototype/widgets/Toast.dart';
import 'package:path/path.dart' as Path;

class EditProfileInfo extends StatefulWidget {
  const EditProfileInfo({Key? key}) : super(key: key);

  @override
  _EditProfileInfoState createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {
  //
  final picker = ImagePicker();
  String? _selectedImage;
  String? _selectedNewImage = null;
  TextEditingController _profileFirstName = TextEditingController();
  TextEditingController _profileLastName = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  //
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> profileData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    setState(() {
      _profileFirstName.text = profileData['profileFirstName'];
      _profileLastName.text = profileData['profileLastName'];
      _phone.text = profileData['phone'];
      _selectedImage = profileData['image'];
      if (profileData['image'] == '') {
        _selectedImage = null;
      }
      _email.text = profileData['email'];
    });
  }

  // Function to handle picking an image from gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          _selectedNewImage = pickedFile.path;
          //print(pickedFile.path);
        } else {
          //print('No image selected.');
        }
      });
    } catch (e) {}
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
      _selectedNewImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/homepage');
            //_auth.checkCurrentUser(context);
          },
          child: const Text(
            'SBS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Color(0xFF222831),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.of(context).pushReplacementNamed('/signin');
            //Navigator.of(context).pushReplacementNamed('/homepage');
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF76ABAE),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF222831),
      endDrawer: CustomEndDrawer(),
      //
      body: SingleChildScrollView(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFF222831),
            //Color(0xFFEEEEEE),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_selectedImage == null && _selectedNewImage == null) {
                        _pickImage(ImageSource.gallery);
                      }
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _selectedNewImage != null
                          ? FileImage(File(_selectedNewImage!)) as ImageProvider
                          : (_selectedImage != null
                              ? NetworkImage(_selectedImage!)
                              : null),
                      child:
                          (_selectedImage == null && _selectedNewImage == null)
                              ? const Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.grey,
                                )
                              : null,
                    ),
                  ),
                  Container(
                    width: 20,
                  ),
                  CustomButton(
                    buttonText: 'Remove Image',
                    color: Colors.green,
                    onPressed: _clearImage,
                    width: 180,
                    height: 30,
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 20,
                    ),
                    // Create your account
                    Container(
                      child: const Text(
                        'Edit your Profile',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    // Create your account

                    // Student Email Field
                    CustomTextField(
                      controller: _email,
                      hintText: 'Student Email',
                      prefixIcon: Icon(Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      enabled: false,
                    ),
                    // Student Email Field
                    // First name Field
                    CustomTextField(
                      controller: _profileFirstName,
                      hintText: 'First Name',
                      prefixIcon: Icon(Icons.person),
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      enabled: true,
                    ),
                    // First name Field

                    // Last name Field
                    CustomTextField(
                      controller: _profileLastName,
                      hintText: 'Last Name',
                      prefixIcon: Icon(Icons.person),
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      enabled: true,
                    ),
                    // Last name Field

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

                    // Reset Password Button
                    CustomButton(
                      buttonText: 'Reset Password',
                      width: 300,
                      color: Colors.red,
                      onPressed: () {
                        resetPassword(_email.text);
                      },
                    ),
                    // Edit Information Button

                    // Edit Information Button
                    CustomButton(
                      buttonText: 'Edit Information',
                      width: 300,
                      color: Color(0xFF76ABAE),
                      onPressed: () {
                        updateProfile();
                      },
                    ),
                    // Edit Information Button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.of(context).pop();
      CustomToastMessage(message: "Password reset email sent");
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      CustomToastMessage(message: "Error: ${e.message}");
    }
  }

  //

  void updateProfile() async {
    final updateprofile;
    final updateprofile1;
    try {
      String fisrtName1 = _profileFirstName.text;
      String lastName1 = _profileLastName.text;
      String phone1 = _phone.text;
      String email1 = _email.text;
      String? image1 = _selectedImage;

      String? imageUrl; // Initialize imageUrl as null

      if (fisrtName1.isEmpty || lastName1.isEmpty || phone1.isEmpty) {
        CustomToastMessage(message: "Please enter all fields");
      } else {
        if (_selectedNewImage != null) {
          // Uploading image to Firebase Storage
          Reference storageReference = FirebaseStorage.instance
              .ref()
              .child('book_images/${Path.basename(_selectedNewImage!)}');
          UploadTask uploadTask =
              storageReference.putFile(File(_selectedNewImage!));
          await uploadTask.whenComplete(() => null);

          // Getting download URL
          imageUrl = await storageReference.getDownloadURL();

          updateprofile1 = UserModel(
            firstName: fisrtName1,
            lastName: lastName1,
            image: imageUrl, // Storing image URL or null if no image selected
            email: email1,
            phone: phone1,
          );
          print('--------');

          await UserModel.updateBookById(email1, updateprofile1);
          print('--------');

          // print('${type1} Updated Successfully');
          Navigator.of(context).pushReplacementNamed('/homepage');
        } else {
          updateprofile = UserModel(
            firstName: fisrtName1,
            lastName: lastName1,
            image: image1, // Storing image URL or null if no image selected
            email: email1,
            phone: phone1,
          );
          print('--------');

          await UserModel.updateBookById(email1, updateprofile);
          print('--------');

          //print('${type1} Updated Successfully');
          Navigator.of(context).pushReplacementNamed('/homepage');
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
