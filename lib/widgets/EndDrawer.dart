import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbs_prototype/auth/firebase_auth_implemention/firebase_auth_services.dart';
import 'package:sbs_prototype/models/user_model.dart';

class CustomEndDrawer extends StatefulWidget {
  const CustomEndDrawer({Key? key}) : super(key: key);

  @override
  _CustomEndDrawerState createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {
  //
  final FirebaseAuthService _auth = FirebaseAuthService();
  User? user = FirebaseAuth.instance.currentUser;
  //
  late Future<UserModel?> _userFuture;

  String? email;
  String? firstName;
  String? lastName;
  String? phone;
/* 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userFuture = UserModel.getUserByemail(user!.email.toString());
  } */
  @override
  void initState() {
    super.initState();
    _userFuture = UserModel.getUserByemail(user!.email.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7, //

      //Container
      child: Drawer(
        backgroundColor: Color(0xFF222831),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //ListView(
          //padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF76ABAE),
              ),
              child: FutureBuilder<UserModel?>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    UserModel user1 = snapshot.data!;
                    // Set the profile data
                    email = user1.email;
                    firstName = user1.firstName;
                    lastName = user1.lastName;
                    phone = user1.phone;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/profileinfo', arguments: {
                          'profileFirstName': user1.firstName,
                          'profileLastName': user1.lastName,
                          'email': user1.email,
                          'image': user1.image,
                          'phone': user1.phone,
                        });
                        /* setState(() {
                          email = user1.email;
                          phone = user1.phone;
                          firstName = user1.firstName;
                          lastName = user1.lastName;
                        }); */
                      },
                      child: Column(
                        //Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFF222831),
                            child: ClipOval(
                              child: SizedBox(
                                width: 100, // Adjust width as needed
                                height: 100, // Adjust height as needed
                                child: user1.image != null &&
                                        user1.image!.isNotEmpty
                                    ? Image.network(user1.image!,
                                        fit: BoxFit.cover)
                                    : Icon(
                                        Icons.person,
                                        size: 55,
                                        color: Color(0xFF76ABAE),
                                      ), // Adjust icon size as needed
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${user1.firstName} ${user1.lastName}',
                            style: TextStyle(
                              color: Color(0xFF222831),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
              /* child: Text(
                '',
                style: TextStyle(
                  color: Color(0xFF222831),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ), */
            ),
            ListTile(
              title: const Text(
                'Add Book/Notebook',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: const Icon(
                FontAwesomeIcons.book, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/sellbook');

                //Navigator.pushReplacementNamed(context, '/sellbook');
              },
            ),
            ListTile(
              title: const Text(
                'My Books/Notebooks',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: const Icon(
                FontAwesomeIcons.bookReader, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/mybooks', arguments: user!.email.toString());

                //Navigator.pushReplacementNamed(context, '/sellbook');
              },
            ),
            ListTile(
              title: Text(
                'Send Book For Repair',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(
                FontAwesomeIcons.scissors, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/sendrepair', arguments: {
                  'firstName': firstName,
                  'lastName': lastName,
                  'email': email,
                  'phone': phone,
                });
                // Add functionality for item 1 here
              },
            ),
            ListTile(
              title: Text(
                'Check Status Of Repairs',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(
                FontAwesomeIcons.scissors, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/checkrepairs',
                  /* arguments: {
                  'firstName': firstName,
                  'lastName': lastName,
                  'email': email,
                  'phone': phone,
                } */
                );
                // Add functionality for item 1 here
              },
            ),
            /* ListTile(
              title: Text(
                'About',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(
                FontAwesomeIcons.circleInfo, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                // Add functionality for item 1 here
              },
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(
                FontAwesomeIcons.user, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                // Add functionality for item 1 here
              },
            ), */
            ListTile(
              title: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(
                FontAwesomeIcons
                    .rightFromBracket, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                // Add functionality for item 1 here
                _auth.signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
/* class CustomEndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService _auth = FirebaseAuthService();
    User? user = FirebaseAuth.instance.currentUser;
    //final UserModel userName;
    //Future<UserModel?> userName =
    //UserModel.getUserByEmail(user!.email.toString());
    late Future<UserModel>? _userFuture;
    

    @override
  void initState() {
    super.initState();
    _userFuture; = UserModel.getUserByEmail(user!.email);
  } 

    return Container(
      width: MediaQuery.of(context).size.width * 0.7, //

      //Container
      child: Drawer(
        backgroundColor: Color(0xFF222831),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //ListView(
          //padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF76ABAE),
              ),
              child: Text(
                '${user?.displayName.toString()}',
                style: TextStyle(
                  color: Color(0xFF222831),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Add Book/Notebook',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(
                Icons.add_circle, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/sellbook');
              },
            ),
            ListTile(
              title: Text(
                'Send Book For Repair',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(
                Icons.build_circle_rounded, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                // Add functionality for item 1 here
              },
            ),
            ListTile(
              title: Text(
                'About',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(
                Icons.circle, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                // Add functionality for item 1 here
              },
            ),
            ListTile(
              title: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(
                Icons.arrow_circle_right_rounded, // Choose the appropriate icon
                color: Colors.white,
              ),
              onTap: () {
                // Add functionality for item 1 here
                _auth.signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
 */