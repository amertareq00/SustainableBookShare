import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:sbs_prototype/auth/firebase_auth_implemention/firebase_auth_services.dart';
import 'package:sbs_prototype/models/book_model.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/DescriptionField.dart';
import 'package:sbs_prototype/widgets/DropdownField.dart';
import 'package:sbs_prototype/widgets/EndDrawer.dart';
import 'package:sbs_prototype/widgets/TextField.dart';
import 'package:sbs_prototype/widgets/Toast.dart';
import 'package:path/path.dart' as Path;

class SellBook extends StatefulWidget {
  const SellBook({super.key});

  @override
  State<SellBook> createState() => _SellBookState();
}

class _SellBookState extends State<SellBook> {
  //final FirebaseAuthService _auth = FirebaseAuthService();
  User? user = FirebaseAuth.instance.currentUser;

  final picker = ImagePicker();
  String? _selectedImage;
  bool isSwitched = false;

  TextEditingController _bookName = TextEditingController();
  TextEditingController _bookCondition = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController? _description = TextEditingController();
  TextEditingController _facultyName = TextEditingController();
  TextEditingController _type = TextEditingController();
  String? selectedBookCondition;
  String? selectedFacultyName;
  String? selectedType;
  //TextEditingController _image = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _bookName.dispose();
    _bookCondition.dispose();
    _price.dispose();
    _description?.dispose();
    _facultyName.dispose();
    _type.dispose();
    // _image.dispose();
  }

  List<String> typeBookNotebook = ['Book', 'Notebook'];

  List<String> bookConditionList = ['New', 'Good', 'Fair'];
  List<String> facultyNamesList = [
    'Architecture & Design',
    'Administrative & Financial Sciences',
    'Arts and Sciences',
    'Pharmacy and Medical Sciences',
    'Information Technology',
    'LAW',
    'Media & Mass Communication',
    'Engineering',
    'Dentistry'
  ];
  void _toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
  }

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
                    'Add Book or Notebook',
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
                  // Book name Field
                  CustomTextField(
                    controller: _bookName,
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.menu_book_rounded),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    enabled: true,
                  ),
                  // Book Name Field

                  /* CustomDropdownMenu(
                    options: bookConditionList,
                    prefixIcon: Icon(Icons.list),
                    hintText: "Condition",
                    controller: _bookCondition,
                  ),

                  CustomDropdownMenu(
                    options: facultyNamesList,
                    prefixIcon: Icon(Icons.list),
                    hintText: "Faculty",
                    controller: _facultyName,
                  ),

                  CustomDropdownMenu(
                    options: typeBookNotebook,
                    prefixIcon: Icon(Icons.list),
                    hintText: "Type",
                    controller: _type,
                  ), */
                  CustomDropdownMenu(
                    options: bookConditionList,
                    selectedOption: selectedBookCondition,
                    onChanged: (value) {
                      setState(() {
                        selectedBookCondition = value!;
                      });
                    },
                    hintText: 'Select Condition',
                    prefixIcon: Icon(Icons.list),
                  ),
                  CustomDropdownMenu(
                    options: facultyNamesList,
                    selectedOption: selectedFacultyName,
                    onChanged: (value) {
                      setState(() {
                        selectedFacultyName = value!;
                      });
                    },
                    hintText: 'Select Faculty ',
                    prefixIcon: Icon(Icons.list),
                  ),
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
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                    width: 300.0,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: const Text(
                            'Donate ',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: _toggleSwitch,
                          activeTrackColor: Color(0xFFEEEEEE),
                          activeColor: Color(0xFF76ABAE),
                        ),
                      ],
                    ),
                  ),
                  // Price Field
                  CustomTextField(
                    controller: _price,
                    hintText: 'Price',
                    prefixIcon: Icon(Icons.monetization_on_rounded),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    obscureText: false,
                    enabled: !isSwitched,
                  ),
                  // Price Field

                  // Description(optional) Field
                  CustomDescriptionField(
                    controller: _description,
                    hintText: 'Description (optional)',
                    keyboardType: TextInputType.multiline,
                  ),
                  // Description(optional) Field

                  // Add Book Button
                  CustomButton(
                    onPressed: () {
                      addBook();
                    },
                    buttonText: 'Add',
                    color: Color(0xFF76ABAE),
                  ),
                  // Add Book Button
                  /* body: Center(
        child: Text(
          'Main Content',
          style: TextStyle(fontSize: 24),
        ),
      ), */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addBook() async {
    try {
      String bookName1 = _bookName.text;
      String? bookCondition1 = selectedBookCondition;
      double price1 = double.tryParse(_price.text) ?? 0.0;
      String? description1 = _description?.text;
      String? facultyName1 = selectedFacultyName;
      String email1 = user!.email.toString();
      String? type1 = selectedType;
      bool donate = isSwitched;
      if (donate == true) {
        price1 = 0.0;
      }
      if (bookName1.isEmpty ||
          //bookCondition1.isEmpty ||
          //facultyName1.isEmpty ||
          email1.isEmpty ||
          //type1.isEmpty ||
          (donate == false && _price.text.isEmpty)) {
        CustomToastMessage(message: "Please enter all fields");
      } else {
        String? imageUrl; // Initialize imageUrl as null

        if (_selectedImage != null) {
          // Uploading image to Firebase Storage
          Reference storageReference = FirebaseStorage.instance
              .ref()
              .child('book_images/${Path.basename(_selectedImage!)}');
          UploadTask uploadTask =
              storageReference.putFile(File(_selectedImage!));
          await uploadTask.whenComplete(() => null);

          // Getting download URL
          imageUrl = await storageReference.getDownloadURL();
        }

        // Storing book details including image URL in Firestore
        final addbook = BookModel(
            bookName: bookName1,
            bookCondition: bookCondition1,
            price: price1,
            description: description1,
            facultyName: facultyName1,
            image: imageUrl, // Storing image URL or null if no image selected
            email: email1,
            type: type1,
            donate: donate);

        await BookModel.addBook(addbook);
        CustomToastMessage(message: '${type1} Added Successfully');
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
    } catch (e) {
      CustomToastMessage(message: "Error: $e");
    }
  }
}
  /* void addBook() async {
    try {
      String bookName1 = _bookName.text;
      String bookCondition1 = _bookCondition.text;
      double price1 = double.parse(_price.text);
      String? description1 = _description?.text;
      String facultyName1 = _facultyName.text;
      String email1 = user!.email.toString();
      String type1 = _type.text;

      if (bookName1.isEmpty ||
          bookCondition1.isEmpty ||
          _price.text.isEmpty ||
          facultyName1.isEmpty ||
          email1.isEmpty ||
          type1.isEmpty) {
        CustomToastMessage(message: "Please enter all fields");
      } else {
        if (_selectedImage == null) {
          CustomToastMessage(message: "Please select an image");
          return;
        }

        // Uploading image to Firebase Storage
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('book_images/${Path.basename(_selectedImage!)}');
        UploadTask uploadTask = storageReference.putFile(File(_selectedImage!));
        await uploadTask.whenComplete(() => null);

        // Getting download URL
        String? imageUrl = await storageReference.getDownloadURL();

        // Storing book details including image URL in Firestore
        final addbook = BookModel(
          bookName: bookName1,
          bookCondition: bookCondition1,
          price: price1,
          description: description1,
          facultyName: facultyName1,
          image: imageUrl, // Storing image URL instead of local path
          email: email1,
          type: type1,
        );

        addbook.addBook(addbook);
        CustomToastMessage(message: '${type1} Added Successfully');
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
    } catch (e) {
      CustomToastMessage(message: "Error: $e");
    }
  } */

  /* void addBook() {
    try {
      String bookName1 = _bookName.text;
      String bookCondition1 = _bookCondition.text;

      double price1 = double.parse(_price.text);
      String? description1 = _description?.text;
      String facultyName1 = _facultyName.text;
      String? image1 = _selectedImage.toString();
      String email1 = user!.email.toString();
      String type1 = _type.text;
      if (bookName1.isEmpty ||
          bookCondition1.isEmpty ||
          _price.text.isEmpty ||
          facultyName1.isEmpty ||
          email1.isEmpty ||
          type1.isEmpty) {
        CustomToastMessage(message: "Please enter all fields");
      } else {
        final addbook = BookModel(
            bookName: bookName1,
            bookCondition: bookCondition1,
            price: price1,
            description: description1,
            facultyName: facultyName1,
            image: image1,
            email: email1,
            type: type1);

        addbook.addBook(addbook);
        CustomToastMessage(message: '${type1} Added Successfully');
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
    } catch (e) {
      CustomToastMessage(message: "Please enter price");
    }
  } */

