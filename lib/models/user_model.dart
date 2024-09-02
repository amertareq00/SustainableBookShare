import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? image;

  const UserModel(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      this.image});

  Map<String, dynamic> storeData() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "image": image,
      'creationDateAndTime': DateTime.now(),
    };
  }

  createUser(UserModel user) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    await _db.collection("Users").add(user.storeData());
  }

  static Future<UserModel?> getUserByemail(String email) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await _db.collection("Users").where('email', isEqualTo: email).get();
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      return UserModel(
        id: querySnapshot.docs.first.id,
        firstName: data['firstName'],
        lastName: data['lastName'],
        email: data['email'],
        phone: data['phone'],
        image: data['image'],
      );
    } else {
      return null;
    }
  }

  static Future<void> updateBookById(
      String email, UserModel updatedprofile) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
          await _db.collection("Users").where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update(updatedprofile.storeData());
      } else {
        print('Book with email: $email not found.');
      }
    } catch (e) {
      print('Error updating book: $e');
    }
  }

/* static Future<List<UserModel>> getAllUsers() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db.collection("Users").get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return UserModel(
        //id: doc.id,
        firstName: data['firstName'],
        lastName: data['lastName'],
        email: data['email'],
        phone: data['phone'],
        password: data['password'],
        confirmPassword: data['confirmPassword'],
      );
    }).toList();
  }

  static Future<List<UserModel>> getUsersByName(String name) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await _db.collection("Users").where('firstName', isEqualTo: name).get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return UserModel(
        id: doc.id,
        firstName: data['firstName'],
        lastName: data['lastName'],
        email: data['email'],
        phone: data['phone'],
        password: data['password'],
        confirmPassword: data['confirmPassword'],
      );
    }).toList();
  } */
}
