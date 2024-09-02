import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sbs_prototype/models/book_model.dart';
import 'package:sbs_prototype/widgets/EndDrawer.dart';
import 'package:sbs_prototype/widgets/SecondBookCard.dart';

class my_books_notebooks extends StatefulWidget {
  const my_books_notebooks({Key? key}) : super(key: key);

  @override
  _my_books_notebooksState createState() => _my_books_notebooksState();
}

class _my_books_notebooksState extends State<my_books_notebooks> {
  //late int id;
  //late Future<List<dynamic>> _dataFuture;
  late Future<List<BookModel>> _booksFuture;
  User? user = FirebaseAuth.instance.currentUser;

  //late String bookEmail;

  @override
  void initState() {
    super.initState();
    _booksFuture = BookModel.getBooksByEmail(user!.email.toString());
  }
  /*  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bookEmail = ModalRoute.of(context)!.settings.arguments as String;
    _booksFuture = BookModel.getBooksByEmail(user!.email.toString())
        as Future<List<BookModel>>;
    /* final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final bookId = args['bookId'];
    final bookEmail = args['bookEmail'];
    _dataFuture = Future.wait([
      BookModel.getBookById(bookId),
      UserModel.getUserByemail(bookEmail),
    ]); */
  } */

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
            //_auth.checkCurrentUser(context);
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF76ABAE),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF222831),
      endDrawer: CustomEndDrawer(),

      /// from enddrawer class
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
            List<BookModel> books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return SecondBookCard(book: books[index]);
              },
            );
          } else {
            return Center(
              child: Text('ss'),
              //BookCard(book: book),
            );
          }
        },
      ),
    );
  }
}
