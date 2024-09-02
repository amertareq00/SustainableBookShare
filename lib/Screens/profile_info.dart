import 'package:flutter/material.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/EndDrawer.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  /* late String _profileFirstName;
  late String _profileLastName;
  late String _phone;
  late String _selectedImage;
  late String _email;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> profileData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    setState(() {
      _profileFirstName = profileData['profileFirstName'];
      _profileLastName = profileData['profileLastName'];
      _phone = profileData['phone'];
      _selectedImage = profileData['image'];
      _email = profileData['email'];
    });
  } */

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> profileData =
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
                      if (profileData['image'] != null &&
                          profileData['image']!.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: profileData['image'] != null
                                    ? Image.network(profileData['image']!)
                                    : Container(),
                                // Show nothing if image is not selected
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
                          width: 100, // Adjust width as needed
                          height: 100, // Adjust height as needed
                          child: profileData['image'] != null &&
                                  profileData['image']!.isNotEmpty
                              ? Image.network(profileData['image']!,
                                  fit: BoxFit.cover)
                              : Icon(
                                  Icons.image,
                                  size: 55,
                                  color: Color(0xFF76ABAE),
                                ), // Adjust icon size as needed
                        ),
                      ),
                    ),
                  ),

                  // image code
                  const SizedBox(width: 20.0),
                  Text(
                    profileData['profileFirstName'] +
                        ' ' +
                        profileData['profileLastName'],
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
                    '${profileData['email']}',
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
                  'First Name: ${profileData['profileFirstName']}',
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
                child: Text(
                  'Last Name: ${profileData['profileLastName']}',
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
                child: Text(
                  'Phone Number: ${profileData['phone']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222831),
                    //decoration:
                  ),
                ),
              ),
              Center(
                  child: CustomButton(
                buttonText: 'Edit Profile Information',
                width: 300,
                color: Color(0xFF76ABAE),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/editprofileinfo', arguments: {
                    'profileFirstName': profileData['profileFirstName'],
                    'profileLastName': profileData['profileLastName'],
                    'email': profileData['email'],
                    'image': profileData['image'],
                    'phone': profileData['phone'],
                  });
                },
              )),
            ],
          ),
        ),
      ),
    );

    //);
  }
}
