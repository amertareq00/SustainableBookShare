import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbs_prototype/models/repair_model.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/DescriptionField.dart';
import 'package:sbs_prototype/widgets/StarRating.dart';
import 'package:sbs_prototype/widgets/Toast.dart';
import 'package:sbs_prototype/widgets/progress_status.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RepairBookCard extends StatefulWidget {
  final RepairModel book;

  const RepairBookCard({required this.book});

  @override
  _RepairBookCardState createState() => _RepairBookCardState();
}

class _RepairBookCardState extends State<RepairBookCard> {
  void showFeedbackDialog(BuildContext context, String documentId) {
    final TextEditingController descriptionController = TextEditingController();
    double rating = 0;
/* 
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Feedback and Rating'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Rating widget
                  StarRating(
                    rating: rating,
                    onRatingChanged: (value) {
                      setState(() {
                        rating = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // CustomDescriptionField
                  CustomDescriptionField(controller: descriptionController),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await updateFirestore(
                      documentId: documentId,
                      rating: rating,
                      description: descriptionController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    ); */
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor:
                  Color(0x00FFFEFE).withOpacity(0.9), // Set the dialog color
              title: Text(
                'Feedback and Rating',
                style:
                    TextStyle(color: Color(0xFF222831)), // Set the title color
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Rating widget
                  StarRating(
                    rating: rating,
                    onRatingChanged: (value) {
                      setState(() {
                        rating = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // CustomDescriptionField
                  CustomDescriptionField(controller: descriptionController),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
// CustomButton for Cancel
                    CustomButton(
                      onPressed: () => Navigator.pop(context),
                      color: Colors.red,
                      width: 130,
                      height: 40.0,
                      buttonText: 'Cancel',
                    ),
                    // CustomButton for Submit
                    CustomButton(
                      onPressed: () async {
                        await updateFirestore(
                          documentId: documentId,
                          rating: rating,
                          description: descriptionController.text,
                        );
                        Navigator.of(context).pushReplacementNamed('/homepage');
                        CustomToastMessage(
                            message: "Thank you for your feedback and rating!");
                      },
                      color: Color(0xFF76ABAE),
                      width: 130,
                      height: 40.0,
                      buttonText: 'Submit',
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> updateFirestore({
    required String documentId,
    required double rating,
    required String description,
  }) async {
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      print("Searching for document with RepairId: $documentId");
      QuerySnapshot querySnapshot = await firestoreInstance
          .collection('Repairs')
          .where('RepairId', isEqualTo: int.parse(documentId))
          .get();

      print("QuerySnapshot length: ${querySnapshot.docs.length}");

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        print("Document found: ${doc.id}");
        await doc.reference.update({
          'rating': rating,
          'feedback': description,
          'IsRepaired': true,
          'RepairedDateAndTime': DateTime.now()
        });
      }
    } catch (e) {
      print("Error updating Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFEEEEEE),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF222831),
                  child: ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: widget.book.image != null &&
                              widget.book.image!.isNotEmpty
                          ? Image.network(widget.book.image!, fit: BoxFit.cover)
                          : Icon(
                              Icons.image,
                              size: 55,
                              color: Color(0xFF76ABAE),
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Text(
                  widget.book.type,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF31363F),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Damage Description: ' + widget.book.description,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF31363F),
              ),
            ),
            Text(
              'Progress Status:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222831),
              ),
            ),
            SizedBox(height: 4.0),
            ProgressStatus(status: widget.book.status),
            SizedBox(height: 10.0),
            widget.book.status == 'Delivered'
                ? Center(
                    child: CustomButton(
                      color: Color(0xFF76ABAE),
                      buttonText: 'Feedback and Rate',
                      onPressed: () => showFeedbackDialog(
                          context, widget.book.RepairId.toString()),
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 4.0),
            Center(
              child: CustomButton(
                buttonText: null,
                width: 300,
                color: Colors.black,
                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                onPressed: () {
                  _launchTelePhoneNumber("0778182837");
                },
              ),
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonText: null,
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                  ),
                  width: 150,
                  color: Color(0xFF25d366),
                  onPressed: () {
                    _launchWhatsAppWithPhoneNumber("0778182837");
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                CustomButton(
                  buttonText: null,
                  icon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  width: 150,
                  color: Color(0xFF4E5FBF),
                  onPressed: () {
                    _launchEmail("amerwwww360@gmail.com");
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  _launchWhatsAppWithPhoneNumber(String phoneNumber) async {
    phoneNumber = "962" + phoneNumber.substring(1);
    try {
      await launchUrlString(
          'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeFull("")}');
    } catch (e) {
      CustomToastMessage(message: 'Error While Launching WhatsApp');
    }
  }

  _launchTelePhoneNumber(String phoneNumber) async {
    try {
      await launchUrlString('tel:$phoneNumber');
    } catch (e) {
      CustomToastMessage(message: 'Error While Launching WhatsApp');
    }
  }

  _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Your Subject Here',
        'body': 'message',
      },
    );

    try {
      await launchUrlString(emailUri.toString());
    } catch (e) {
      // Replace this with your custom toast or error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error while launching email client')),
      );
    }
  }
}
