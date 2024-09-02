import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbs_prototype/models/book_model.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/DescriptionField.dart';
import 'package:sbs_prototype/widgets/DropdownField.dart';
import 'package:sbs_prototype/widgets/EndDrawer.dart';
import 'package:sbs_prototype/widgets/TextField.dart';
import 'package:path/path.dart' as Path;

class EditBookInfo extends StatefulWidget {
  const EditBookInfo({Key? key}) : super(key: key);

  @override
  _EditBookInfoState createState() => _EditBookInfoState();
}

class _EditBookInfoState extends State<EditBookInfo> {
  //
  User? user = FirebaseAuth.instance.currentUser;
  final picker = ImagePicker();
  String? _selectedImage;
  String? _selectedNewImage = null;

  bool isSwitched = false;
  late int idFromLastPage;
  TextEditingController _bookName = TextEditingController();
  TextEditingController _bookCondition = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController? _description = TextEditingController();
  TextEditingController _facultyName = TextEditingController();
  TextEditingController _type = TextEditingController();
  String? selectedBookCondition;
  String? selectedFacultyName;
  String? selectedType;
  late String? _bookConditionO;
  late String? _facultyNameO;
  late String? _typeO;
  /* late String? _bookNameO;
  late String? _priceO;
  late String? _descriptionO; */

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic> bookInfo =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //_bookNameO = bookInfo['bookName'];
    _bookName.text = bookInfo['bookName'];
    //
    //_bookCondition.text = bookInfo['bookCondition'];
    _bookConditionO = bookInfo['bookCondition'];
    //
    _price.text = bookInfo['price'].toString();
    //
    _description?.text = bookInfo['description'];
    //_facultyName.text = bookInfo['facultyName'];
    _facultyNameO = bookInfo['facultyName'];
    //
    //_type.text = bookInfo['type'];
    _typeO = bookInfo['type'];
    //
    _selectedImage = bookInfo['image'];
    if (bookInfo['image'] == '') {
      _selectedImage = null;
    }
    isSwitched = bookInfo['donate'];
    idFromLastPage = bookInfo['id'];

    /* setState(() {
      _bookName.text = bookInfo['bookName'];
      //
      //_bookCondition.text = bookInfo['bookCondition'];
      selectedBookCondition = bookInfo['bookCondition'];
      //
      _price.text = bookInfo['price'].toString();
      //
      _description?.text = bookInfo['description'];
      //_facultyName.text = bookInfo['facultyName'];
      selectedFacultyName = bookInfo['facultyName'];
      //
      //_type.text = bookInfo['type'];
      selectedType = bookInfo['type'];
      //
      _selectedImage = bookInfo['image'];
      if (bookInfo['image'] == '') {
        _selectedImage = null;
      }
      isSwitched = bookInfo['donate'];
      idFromLastPage = bookInfo['id'];
    }); */
    /* setState(() {

      //_bookName.text = bookInfo['bookName'];
      //_bookCondition.text = bookInfo['bookCondition'];
      _price.text = bookInfo['price'].toString();
      //_description?.text = bookInfo['description'];
      //_facultyName.text = bookInfo['facultyName'];
      //_type.text = bookInfo['type'];
      _bookNameO = bookInfo['bookName'];
      _bookConditionO = bookInfo['bookCondition'];
      //_priceO = bookInfo['price'].toString();
      _descriptionO = bookInfo['description'];
      _facultyNameO = bookInfo['facultyName'];
      _typeO = bookInfo['type'];
      _selectedImage = bookInfo['image'];
      if (bookInfo['image'] == '') {
        _selectedImage = null;
      }
      isSwitched = bookInfo['donate'];
      idFromLastPage = bookInfo['id'];
      print("_selectedNewImage: $_selectedNewImage");
      print("_selectedNewImage: $_selectedImage");
    }); */
  }

/* 
  @override
  void initState() {
    super.initState();
    _bookName.text = bookInfo['bookName'];
    _bookCondition.text = bookInfo['bookCondition'];
    _price.text = bookInfo['price'].toString();
    _description?.text = bookInfo['description'];
    _facultyName.text = bookInfo['facultyName'];
    _type.text = bookInfo['type'];
    _selectedImage = bookInfo['image'];
    if (bookInfo['image'] == '') {
      _selectedImage = null;
    }
    isSwitched = bookInfo['donate'];
    idFromLastPage = bookInfo['id'];
  } */

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
      body: SingleChildScrollView(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                    color: Colors.red,
                    onPressed: _clearImage,
                    width: 180,
                    height: 30,
                  ),
                ],
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
                      hintText: '', //'${_bookConditionO}',
                      controller: _bookCondition,
                      //value: _facultyName.text,
                      onChanged: (controller) {
                        setState(() {
                          _facultyName.text = controller!;
                        });
                      },
                    ),

                    CustomDropdownMenu(
                      options: facultyNamesList,
                      prefixIcon: Icon(Icons.list),
                      hintText: '', //'${_facultyNameO}',
                      controller: _facultyName,
                    ),

                    CustomDropdownMenu(
                      options: typeBookNotebook,
                      prefixIcon: Icon(Icons.list),
                      hintText: '', //'${_typeO}',
                      controller: _type,
                    ), */
                    CustomDropdownMenu(
                      options: bookConditionList,
                      selectedOption: selectedBookCondition,
                      onChanged: (value) {
                        setState(() {
                          selectedBookCondition = value;
                        });
                      },
                      hintText: '${_bookConditionO}',
                      prefixIcon: Icon(Icons.list),
                    ),
                    CustomDropdownMenu(
                      options: facultyNamesList,
                      selectedOption: selectedFacultyName,
                      onChanged: (value) {
                        setState(() {
                          selectedFacultyName = value;
                        });
                      },
                      hintText: '${_facultyNameO}',
                      prefixIcon: Icon(Icons.list),
                    ),
                    CustomDropdownMenu(
                      options: typeBookNotebook,
                      selectedOption: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                        });
                      },
                      hintText: '${_typeO}',
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
                      hintText: 'Description (Optional)',
                      keyboardType: TextInputType.multiline,
                    ),
                    // Description(optional) Field
                  ],
                ),
              ),
              Center(
                child: CustomButton(
                  buttonText: 'Edit Information',
                  width: 300,
                  color: Color(0xFF76ABAE),
                  onPressed: () {
                    updateBook();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateBook() async {
    final updatebook;
    final updatebook1;
    try {
      String bookName1 = _bookName.text;
      String? bookCondition1 = selectedBookCondition ?? _bookConditionO;
      String? facultyName1 = selectedFacultyName ?? _facultyNameO;
      String? type1 = selectedType ?? _typeO;
      String? description1 = _description!.text;
      /* String? bookName1 =
          _bookName.text.isNotEmpty ? _bookName.text : _bookNameO;
      String? bookCondition1 = _bookCondition.text.isNotEmpty
          ? _bookCondition.text
          : _bookConditionO;
      String? facultyName1 =
          _facultyName.text.isNotEmpty ? _facultyName.text : _facultyNameO;
      String? type1 = _type.text.isNotEmpty ? _type.text : _typeO; 
      
      String? description1 =
          _description!.text.isNotEmpty ? _description?.text : _descriptionO;*/

      double price1 = double.tryParse(_price.text) ?? 0.0;

      String email1 = user!.email.toString();
      bool donate = isSwitched;
      String? image1 = _selectedImage;
      if (donate == true) {
        price1 = 0.0;
      }
      int id = idFromLastPage;
      String? imageUrl; // Initialize imageUrl as null

      /*   if (bookName1.isEmpty ||
          bookCondition1.isEmpty ||
          facultyName1.isEmpty ||
          email1.isEmpty ||
          type1.isEmpty ||
          (donate == false && _price.text.isEmpty)) {
        CustomToastMessage(message: "Please enter all fields");
      } else { */
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

        updatebook1 = BookModel(
            bookName: bookName1,
            bookCondition: bookCondition1,
            price: price1,
            description: description1,
            facultyName: facultyName1,
            image: imageUrl, // Storing image URL or null if no image selected
            email: email1,
            type: type1,
            donate: donate);
        print('--------');

        await BookModel.updateBookById(id, updatebook1);
        print('--------');

        // print('${type1} Updated Successfully');
        Navigator.of(context).pushReplacementNamed('/homepage');
      } else {
        updatebook = BookModel(
            bookName: bookName1,
            bookCondition: bookCondition1,
            price: price1,
            description: description1,
            facultyName: facultyName1,
            image: image1, // Storing image URL or null if no image selected
            email: email1,
            type: type1,
            donate: donate);
        print('--------');

        await BookModel.updateBookById(id, updatebook);
        print('--------');

        //print('${type1} Updated Successfully');
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
      //}
    } catch (e) {
      print("Error: $e");
    }
  }
}
