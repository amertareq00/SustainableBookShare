import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookModel {
  final int? BookId;
  final String bookName;
  final String? bookCondition;
  final double? price;
  final String? description;
  final String? facultyName;
  final String? image;
  final String email; // New property for user email
  final String? type;
  final bool donate;
  final bool IsDeleted;

  const BookModel(
      {this.BookId,
      required this.bookName,
      required this.bookCondition,
      this.price,
      this.description,
      required this.facultyName,
      this.image,
      required this.email,
      required this.type,
      required this.donate,
      this.IsDeleted = false // Include email in constructor
      });

  storeData() {
    return {
      'BookId': BookId,
      'bookName': bookName,
      'bookCondition': bookCondition,
      'price': price,
      'description': description,
      'facultyName': facultyName,
      'image': image,
      'email': email, // Include email in JSON representation
      'type': type,
      'donate': donate,
      'creationDateAndTime': DateTime.now(),
      'creationBy': email,
      'IsDeleted': IsDeleted,
    };
  }

  storeData2() {
    return {
      'bookName': bookName,
      'bookCondition': bookCondition,
      'price': price,
      'description': description,
      'facultyName': facultyName,
      'image': image,
      'email': email, // Include email in JSON representation
      'type': type,
      'donate': donate,
      'modifiedDateAndTime': DateTime.now(),
      'modifiedBy': email,
    };
  }

  storeData3() {
    return {
      'bookName': bookName,
      'bookCondition': bookCondition,
      'price': price,
      'description': description,
      'facultyName': facultyName,
      'image': image,
      'email': email, // Include email in JSON representation
      'type': type,
      'donate': donate,
      'modifiedDateAndTime': DateTime.now(),
      'modifiedBy': email,
    };
  }

  static Future<int> getNextId(String collection) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db
        .collection(collection)
        .orderBy('BookId', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      int currentMaxId = querySnapshot.docs.first.get('BookId');
      return currentMaxId + 1;
    } else {
      return 1; // Start from 1 if no documents exist
    }
  }

  static Future<void> addBook(BookModel book) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    int nextId = await getNextId('Books');
    book = BookModel(
      BookId: nextId,
      bookName: book.bookName,
      bookCondition: book.bookCondition,
      price: book.price,
      description: book.description,
      facultyName: book.facultyName,
      image: book.image,
      email: book.email,
      type: book.type,
      donate: book.donate,
    );
    await _db.collection('Books').add(book.storeData());
  }

  static Future<List<BookModel>> getAllBooks() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db
        .collection("Books")
        //.orderBy("BookId", descending: true)
        .where('IsDeleted', isEqualTo: false)
        //.where('email', isEqualTo: '202011141@uopstd.edu.jo')
        //.where('BookId', isEqualTo: 16)

        .get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return BookModel(
        BookId: data['BookId'],
        bookName: data['bookName'],
        bookCondition: data['bookCondition'],
        price: data['price'],
        description: data['description'],
        facultyName: data['facultyName'],
        image: data['image'] ?? '',
        email: data['email'],
        type: data['type'], // Retrieve email from Firestore
        donate: data['donate'],
      );
    }).toList();
  }

  static Future<BookModel?> getBookById(int id) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db
        .collection("Books")
        .where('BookId', isEqualTo: id)
        //.where('IsDeleted', isEqualTo: false)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      return BookModel(
        BookId: data['BookId'],
        bookName: data['bookName'],
        bookCondition: data['bookCondition'],
        price: data['price'],
        description: data['description'],
        facultyName: data['facultyName'],
        image: data['image'] ?? '',
        email: data['email'],
        type: data['type'], // Retrieve email from Firestore
        donate: data['donate'],
      );
    } else {
      return null;
    }
  }

  static Future<List<BookModel>> getBooksByEmail(String email) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db
        .collection("Books")
        //.orderBy("id", descending: false)
        .where('email', isEqualTo: email)
        .where('IsDeleted', isEqualTo: false)
        //.where('id', isEqualTo: )
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return BookModel(
        BookId: data['BookId'],
        bookName: data['bookName'],
        bookCondition: data['bookCondition'],
        price: data['price'],
        description: data['description'],
        facultyName: data['facultyName'],
        image: data['image'] ?? '',
        email: data['email'],
        type: data['type'],
        donate: data['donate'],
      );
    }).toList();
  }

  static Future<void> updateBookById(int id, BookModel updatedBook) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
          await _db.collection("Books").where('BookId', isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update(updatedBook.storeData2());
      } else {
        print('Book with id $id not found.');
      }
    } catch (e) {
      print('Error updating book: $e');
    }
  }

  static Future<void> deleteBookById(int id) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    try {
      QuerySnapshot querySnapshot =
          await _db.collection("Books").where('BookId', isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update({
          'IsDeleted': true,
          'DeletedDateAndTime': DateTime.now(),
          'DeletedBy': user?.email.toString(),
        });
      } else {
        print('Book with id $id not found.');
      }
    } catch (e) {
      print('Error updating book: $e');
    }
  }

  static Future<void> sellBook(int id) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    try {
      QuerySnapshot querySnapshot =
          await _db.collection("Books").where('BookId', isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        //int nextId = await getNextId('SoldBooks');
        // Generate a special ID for the sold book

        // Move the book data to the "SoldBooks" collection
        await _db.collection('SoldBooks').doc().set({
          //'BookId': nextId,
          'BookIdFromBooks': data['BookId'],
          'bookName': data['bookName'],
          'bookCondition': data['bookCondition'],
          'price': data['price'],
          'description': data['description'],
          'facultyName': data['facultyName'],
          'image': data['image'] ?? '',
          'email': data['email'],
          'type': data['type'],
          'donate': data['donate'],
          'modifiedBy': data['modifiedBy'],
          'modifiedDateAndTime': data['modifiedDateAndTime'],
          'creationBy': data['creationBy'],
          'creationDateAndTime': data['creationDateAndTime'],
          'SoldDateAndTime': DateTime.now(),
          'SoldBy': user?.email.toString(),
          'IsDeleted': true,
          'DeletedDateAndTime': DateTime.now(),
          'DeletedBy': user?.email.toString(),
        });

        // Update the deletion variables for the original book
        DocumentReference documentReference = documentSnapshot.reference;
        await documentReference.update({
          'IsDeleted': true,
          'DeletedDateAndTime': DateTime.now(),
          'DeletedBy': user?.email.toString(),
        });
      } else {
        print('Book with id $id not found.');
      }
    } catch (e) {
      print('Error selling book: $e');
    }
  }
}
