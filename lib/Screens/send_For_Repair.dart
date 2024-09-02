import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbs_prototype/models/repair_model.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/DescriptionField.dart';
import 'package:sbs_prototype/widgets/DropdownField.dart';
import 'package:sbs_prototype/widgets/EndDrawer.dart';
import 'package:sbs_prototype/widgets/Toast.dart';
import 'package:path/path.dart' as Path;

class SendForRepair extends StatefulWidget {
  const SendForRepair({super.key});

  @override
  State<SendForRepair> createState() => _SendForRepairState();
}

class _SendForRepairState extends State<SendForRepair> {
  //final FirebaseAuthService _auth = FirebaseAuthService();
  User? user = FirebaseAuth.instance.currentUser;

  final picker = ImagePicker();
  String? _selectedImage;

  TextEditingController _description = TextEditingController();
  TextEditingController _type = TextEditingController();
  String? selectedType;
  //TextEditingController _image = TextEditingController();
  late String _firstName;
  late String _lastName;
  late String _phone;
  late String _email;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> profileData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    setState(() {
      _firstName = profileData['firstName'];
      _lastName = profileData['lastName'];
      _phone = profileData['phone'];
      _email = profileData['email'];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _description.dispose();
    _type.dispose();
    // _image.dispose();
  }

  List<String> typeBookNotebook = ['Book', 'Notebook'];

  // Function to handle picking an image from gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          _selectedImage = pickedFile.path;
          //print(pickedFile.path);
        } else {
          //print('No image selected.');
        }
      });
    } catch (e) {}
  }

  // Function to show dialog with full-size image
  void _showFullImageDialog() {
    if (_selectedImage != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
              width: 300,
              height: 300,
              child: _selectedImage != null
                  ? Image.file(File(_selectedImage!))
                  : Container(),
              // Show nothing if image is not selected
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/homepage');
            //_auth.checkCurrentUser(context);
            //Navigator.of(context).pop(); // Navigate back
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
            Navigator.of(context).pop(); // Navigate back
            //Navigator.of(context).pushReplacementNamed('/signin');
            //_auth.checkCurrentUser(context);
          },
        ),
        backgroundColor: Color(0xFF76ABAE),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF222831),
      endDrawer: CustomEndDrawer(),
      body: Container(
        padding: EdgeInsets.all(25),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3),
                  child: GestureDetector(
                    onTap: () {
                      if (_selectedImage == null) {
                        _pickImage(ImageSource.gallery);
                      } else {
                        _showFullImageDialog();
                      }
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _selectedImage != null
                          ? FileImage(File(_selectedImage!))
                          : null,
                      child: _selectedImage == null
                          ? const Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                ),
                // Add Book or Notebook
                Container(
                  margin: EdgeInsets.symmetric(vertical: 44.0),
                  child: Text(
                    'Add Image',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 22.0,
                    ),
                  ),
                ),
                // Add Book or Notebook
              ],
            ),
            Container(
              height: 10,
            ),
            Center(
              child: Column(
                children: [
                  CustomDropdownMenu(
                    options: typeBookNotebook,
                    selectedOption: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    hintText: 'Select Type',
                    prefixIcon: Icon(Icons.list),
                  ),

                  // Description(optional) Field
                  CustomDescriptionField(
                    controller: _description,
                    hintText: 'Damage Description',
                    keyboardType: TextInputType.multiline,
                  ),
                  // Description Field

                  CustomButton(
                    onPressed: () {
                      sendBook();
                    },
                    buttonText: 'Send',
                    color: Color(0xFF76ABAE),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendBook() async {
    try {
      String description1 = _description.text;
      String email1 = _email;
      String? type1 = selectedType;
      String phone = _phone;
      String bookOwner = _firstName + ' ' + _lastName;

      if (description1.isEmpty || email1.isEmpty || type1!.isEmpty) {
        CustomToastMessage(message: "Please enter all fields");
      } else {
        String? imageUrl; // Initialize imageUrl as null

        if (_selectedImage != null) {
          // Uploading image to Firebase Storage
          Reference storageReference = FirebaseStorage.instance
              .ref()
              .child('repair_book_images/${Path.basename(_selectedImage!)}');
          UploadTask uploadTask =
              storageReference.putFile(File(_selectedImage!));
          await uploadTask.whenComplete(() => null);

          // Getting download URL
          imageUrl = await storageReference.getDownloadURL();
        }

        // Storing book details including image URL in Firestore
        final addbook = RepairModel(
            description: description1,
            image: imageUrl, // Storing image URL or null if no image selected
            email: email1,
            type: type1,
            ownerName: bookOwner,
            ownerPhone: phone,
            rating: 0);

        await RepairModel.sendRepair(addbook);
        CustomToastMessage(message: '${type1} Sent Successfully');
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
    } catch (e) {
      CustomToastMessage(message: "Error: $e");
    }
  }
}

class RepairedModel {}
