import 'package:cloud_firestore/cloud_firestore.dart';

class RepairModel {
  final int? RepairId;
  final String description;
  final String? image;
  final String email;
  final String type;
  final String ownerName;
  final String ownerPhone;
  final String? status;
  final bool IsRepaired;
  final String feedback;
  final double rating;

  const RepairModel({
    this.RepairId,
    required this.description,
    this.image,
    required this.email,
    required this.type,
    required this.ownerName,
    required this.ownerPhone,
    this.IsRepaired = false,
    this.status,
    this.feedback = 'null',
    required this.rating,
  });

  storeData() {
    return {
      'RepairId': RepairId,
      'description': description,
      'image': image,
      'email': email, // Include email in JSON representation
      'type': type,
      'sentDateAndTime': DateTime.now(),
      'sentBy': email,
      'IsRepaired': IsRepaired,
      'ownerName': ownerName,
      'ownerPhone': ownerPhone,
      'status': 'null',
      'feedback': feedback,
      'rating': rating
    };
  }

  static Future<int> getNextId(String collection) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db
        .collection(collection)
        .orderBy('RepairId', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      int currentMaxId = querySnapshot.docs.first.get('RepairId');
      return currentMaxId + 1;
    } else {
      return 1; // Start from 1 if no documents exist
    }
  }

  static Future<void> sendRepair(RepairModel Repair) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    int nextId = await getNextId('Repairs');
    Repair = RepairModel(
      RepairId: nextId,
      description: Repair.description,
      image: Repair.image,
      email: Repair.email,
      type: Repair.type,
      ownerName: Repair.ownerName,
      ownerPhone: Repair.ownerPhone,
      feedback: Repair.feedback,
      rating: Repair.rating,
    );
    await _db.collection('Repairs').add(Repair.storeData());
  }

  static Future<List<RepairModel>> getAllRepairs(bool IsRepaired) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db
        .collection("Repairs")
        .where('IsRepaired', isEqualTo: IsRepaired)
        .get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return RepairModel(
        RepairId: data['RepairId'],
        description: data['description'],
        image: data['image'] ?? '',
        email: data['email'],
        type: data['type'],
        ownerName: data['ownerName'],
        ownerPhone: data['ownerPhone'],
        rating: data['rating'].toDouble(),
        feedback: data['feedback'],
      );
    }).toList();
  }

  static Future<RepairModel?> getRepairById(int id) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db
        .collection("Repairs")
        .where('RepairId', isEqualTo: id)
        //.where('IsRepaired', isEqualTo: false)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      return RepairModel(
        RepairId: data['RepairId'],
        description: data['description'],
        image: data['image'] ?? '',
        email: data['email'],
        type: data['type'],
        ownerName: data['ownerName'],
        ownerPhone: data['ownerPhone'],
        rating: data['rating'].toDouble(),
        feedback: data['feedback'], // Retrieve email from Firestore
      );
    } else {
      return null;
    }
  }

  static Future<List<RepairModel>> getRepairsByEmail(String email) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _db
        .collection("Repairs")
        //.orderBy("id", descending: false)
        .where('email', isEqualTo: email)
        .where('IsRepaired', isEqualTo: false)
        //.where('id', isEqualTo: )
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return RepairModel(
        RepairId: data['RepairId'],
        description: data['description'],
        image: data['image'] ?? '',
        email: data['email'],
        type: data['type'],
        ownerName: data['ownerName'],
        ownerPhone: data['ownerPhone'],
        status: data['status'],
        rating: data['rating'].toDouble(),
        feedback: data['feedback'],
      );
    }).toList();
  }
}
