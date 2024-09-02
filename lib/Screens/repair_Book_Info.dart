import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/Toast.dart';
import 'package:sbs_prototype/widgets/progress_status.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RepairBookInfo extends StatefulWidget {
  const RepairBookInfo({Key? key}) : super(key: key);

  @override
  _RepairBookInfoState createState() => _RepairBookInfoState();
}

class _RepairBookInfoState extends State<RepairBookInfo> {
  User? user = FirebaseAuth.instance.currentUser;

  late int idFromLastPage;
  //late String _status;

  String _status = 'null'; // Default status

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> repairbookData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      idFromLastPage = repairbookData['id'];
    });
    _fetchStatusFromFirebase();
  }

  Future<void> _fetchStatusFromFirebase() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Repairs')
          .where('RepairId', isEqualTo: idFromLastPage)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot doc = querySnapshot.docs.first;
        final String status = doc.get('status');
        setState(() {
          _status = status; //.isNotEmpty ? status : 'Received';
        });
      }
    } catch (e) {
      print("some rrrrr");
    }
  }

  void _updateProgress() {
    List<String> statuses = [
      'Received',
      'Under Repairing',
      'Repaired',
      'Delivered'
    ];
    int currentStep = statuses.indexOf(_status);

    if (currentStep < statuses.length - 1) {
      setState(() {
        _status = statuses[currentStep + 1];
      });

      FirebaseFirestore.instance
          .collection('Repairs')
          .where('RepairId', isEqualTo: idFromLastPage)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          final DocumentSnapshot doc = querySnapshot.docs.first;
          doc.reference.update({'status': _status});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> repairbookData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/repairhomepage');
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
                      if (repairbookData['image'] != null &&
                          repairbookData['image']!.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: repairbookData['image'] != null
                                    ? Image.network(repairbookData['image']!)
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
                          child: repairbookData['image'] != null &&
                                  repairbookData['image']!.isNotEmpty
                              ? Image.network(repairbookData['image']!,
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
                    repairbookData['type'],
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
                    '${repairbookData['ownerName']}',
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
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height: 8.0),
                  Text(
                    'Damage Description:',
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
                      repairbookData['description'].toString(), // from db
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFF31363F),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
              // Add ProgressStatus Widget Here
              Text(
                'Progress Status:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222831),
                ),
              ),
              SizedBox(height: 4.0),
              ProgressStatus(status: _status), // Add ProgressStatus Widget
              SizedBox(height: 10.0),
              Center(
                child: CustomButton(
                  buttonText: 'Update Progress',
                  width: 300,
                  color: Color(0xFF76ABAE),
                  onPressed: _updateProgress,
                ),
              ),
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
                    _launchTelePhoneNumber(repairbookData['ownerPhone']);
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
                      _launchWhatsAppWithPhoneNumber(
                          repairbookData['ownerPhone']);
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
                      _launchEmail(repairbookData['email']);
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
