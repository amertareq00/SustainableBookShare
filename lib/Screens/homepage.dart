import 'package:flutter/material.dart';
import 'package:sbs_prototype/models/book_model.dart';
import 'package:sbs_prototype/widgets/BookCard.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/DropdownField.dart';
import 'package:sbs_prototype/widgets/EndDrawer.dart';
import 'package:sbs_prototype/widgets/TextField.dart';
import 'package:sbs_prototype/widgets/Toast.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //final FirebaseAuthService _auth = FirebaseAuthService();

  late Future<List<BookModel>> _booksFuture;
  List<BookModel> _books = []; // Initialize with an empty list
  List<BookModel> _filteredBooks = []; // Initialize with an empty list

  bool isSwitched = false;
  String? selectedBookCondition;
  String? selectedFacultyName;
  String? selectedType1;
  TextEditingController _bookCondition = TextEditingController();
  TextEditingController _facultyName = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _maxPrice = TextEditingController();
  TextEditingController _minPrice = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _bookCondition.dispose();
    _facultyName.dispose();
    _type.dispose();
    _maxPrice.dispose();
    _minPrice.dispose();
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

  @override
  void initState() {
    super.initState();
    _booksFuture = BookModel.getAllBooks();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF222831),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: 350,
                  height: 455,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdownMenu(
                          options: bookConditionList,
                          selectedOption: selectedBookCondition,
                          onChanged: (value) {
                            setState(() {
                              selectedBookCondition = value;
                            });
                          },
                          hintText: 'Condition',
                          prefixIcon: Icon(Icons.list),
                        ),
                        SizedBox(height: 10),
                        CustomDropdownMenu(
                          options: facultyNamesList,
                          selectedOption: selectedFacultyName,
                          onChanged: (value) {
                            setState(() {
                              selectedFacultyName = value;
                            });
                          },
                          hintText: 'Faculty',
                          prefixIcon: Icon(Icons.list),
                        ),
                        SizedBox(height: 10),
                        CustomDropdownMenu(
                          options: typeBookNotebook,
                          selectedOption: selectedType1,
                          onChanged: (value) {
                            setState(() {
                              selectedType1 = value;
                            });
                          },
                          hintText: 'Type',
                          prefixIcon: Icon(Icons.list),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextField(
                              hintText: 'From',
                              obscureText: false,
                              enabled: !isSwitched,
                              prefixIcon: Icon(Icons.pin_rounded),
                              controller: _minPrice,
                              width: 120,
                              height: 50,
                              keyboardType: TextInputType.number,
                            ),
                            CustomTextField(
                              hintText: 'To',
                              obscureText: false,
                              enabled: !isSwitched,
                              prefixIcon: Icon(Icons.pin_rounded),
                              controller: _maxPrice,
                              width: 120,
                              height: 50,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Donated',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(width: 10),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                              activeTrackColor: Color(0xFFEEEEEE),
                              activeColor: Color(0xFF76ABAE),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              buttonText: "Apply",
                              onPressed: _applyFilter,
                              color: Colors.green,
                              width: 130,
                              height: 40.0,
                            ),
                            CustomButton(
                              buttonText: "Clear",
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/homepage');
                              },
                              color: Colors.red,
                              width: 130,
                              height: 40.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/homepage');
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
            icon: const Icon(Icons.filter_alt_rounded),
            onPressed: () {
              _showFilterDialog();
              //Navigator.of(context).pushReplacementNamed('/signin');
              // _auth.checkCurrentUser(context);
            },
          ),
          backgroundColor: Color(0xFF76ABAE),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFF222831),
        endDrawer: CustomEndDrawer(),

        //body
        body: FutureBuilder<List<BookModel>>(
          future: _booksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              _books = snapshot.data!;
              List<BookModel> booksToDisplay =
                  _filteredBooks.isNotEmpty ? _filteredBooks : _books;

              return ListView.builder(
                itemCount: booksToDisplay.length,
                itemBuilder: (context, index) {
                  return BookCard(book: booksToDisplay[index]);
                },
              );
            } else {
              return Center(
                child: Text(
                  'No books available.',
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
              );
            }
          },
        ),
      ),
      onWillPop: () async => false,
    );
  }

  void _applyFilter() {
    // Extract filter criteria
    String? selectedFaculty = selectedFacultyName;
    String? selectedCondition = selectedBookCondition;
    String? selectedType = selectedType1;
    double? minPrice = double.tryParse(_minPrice.text) ?? 0.0;
    double? maxPrice = double.tryParse(_maxPrice.text) ?? double.infinity;

    // Apply filter
    List<BookModel> filteredBooks = _books.where((book) {
      bool matchesFaculty =
          selectedFaculty == null || book.facultyName == selectedFaculty;
      bool matchesCondition =
          selectedCondition == null || book.bookCondition == selectedCondition;
      bool matchesType = selectedType == null || book.type == selectedType;
      bool matchesPrice =
          (book.price! >= minPrice) && (book.price! <= maxPrice);
      bool matchesDonated = !isSwitched || book.donate;

      return matchesFaculty &&
          matchesCondition &&
          matchesType &&
          matchesPrice &&
          matchesDonated;
    }).toList();

    // Update UI with filtered books
    setState(() {
      _filteredBooks = filteredBooks;
      if (_filteredBooks.isEmpty) {
        CustomToastMessage(message: 'No books found');
      }
    });
    Navigator.of(context).pop();
  }
}
