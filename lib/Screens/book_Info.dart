import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sbs_prototype/models/book_model.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/EndDrawer.dart';
import 'package:sbs_prototype/widgets/Toast.dart';

class BookInfo extends StatefulWidget {
  const BookInfo({Key? key}) : super(key: key);

  @override
  _BookInfoState createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  User? user = FirebaseAuth.instance.currentUser;

  late int idFromLastPage;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> bookData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      idFromLastPage = bookData['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> bookData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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

      /// from enddrawer class
      body: SingleChildScrollView(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (bookData['image'] != null &&
                          bookData['image']!.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: bookData['image'] != null
                                    ? Image.network(bookData['image']!)
                                    : Container(),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFF222831),
                      child: ClipOval(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: bookData['image'] != null &&
                                  bookData['image']!.isNotEmpty
                              ? Image.network(bookData['image']!,
                                  fit: BoxFit.cover)
                              : Icon(
                                  Icons.image,
                                  size: 55,
                                  color: Color(0xFF76ABAE),
                                ),
                        ),
                      ),
                    ),
                  ),

                  // image code
                  const SizedBox(width: 20.0),
                  Text(
                    bookData['bookName'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222831),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  //color: Colors.yellow,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF76ABAE).withOpacity(0.9),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20),

                  child: Text(
                    '${bookData['type']} In a ${bookData['bookCondition']} Condition',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222831),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Faculty: ${bookData['facultyName']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222831),
                    //decoration:
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              bookData['donate']
                  ? Text(
                      'For Free (Donate)',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222831),
                      ),
                    )
                  : Text(
                      'Price: ${bookData['price']} JD',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222831),
                      ),
                    ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              //if (book.description.toString().isEmpty)
              bookData['description'].toString().isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222831),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Container(
                          width: 340,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF222831)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            bookData['description'].toString(), // from db
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Color(0xFF31363F),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    )
                  : Container(),

              Center(
                child: CustomButton(
                  buttonText: 'Edit ${bookData['type']} Information',
                  width: 300,
                  color: Color(0xFF76ABAE),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/editbookinfo', arguments: {
                      'id': bookData['id'],
                      'email': bookData['email'],
                      'bookCondition': bookData['bookCondition'],
                      'bookName': bookData['bookName'],
                      'description': bookData['description'],
                      'price': bookData['price'],
                      'donate': bookData['donate'],
                      'facultyName': bookData['facultyName'],
                      'image': bookData['image'],
                      'type': bookData['type'],
                    });
                  },
                ),
              ),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    buttonText: "Delete",
                    width: 150,
                    color: Colors.red,
                    onPressed: () {
                      deleteBook();
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomButton(
                    buttonText: "Sold",
                    width: 150,
                    color: Color(0xFF222831),
                    onPressed: () {
                      soldBook();
                    },
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  void deleteBook() async {
    try {
      int id = idFromLastPage;
      await BookModel.deleteBookById(id);
      Navigator.of(context).pushReplacementNamed('/homepage');
      CustomToastMessage(message: "Book deleted successfully");
    } catch (e) {
      CustomToastMessage(
          message: "Failed to delete the book. Please try again.");
    }
  }

  void soldBook() async {
    try {
      int id = idFromLastPage;
      await BookModel.sellBook(id);
      Navigator.of(context).pushReplacementNamed('/homepage');
    } catch (e) {
      print("Error: $e");
    }
  }
}
