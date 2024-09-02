import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sbs_prototype/Screens/Get_Book_Notebook.dart';
import 'package:sbs_prototype/Screens/book_Info.dart';
import 'package:sbs_prototype/Screens/check_repairs.dart';
import 'package:sbs_prototype/Screens/edit_Book_Info.dart';
import 'package:sbs_prototype/Screens/edit_profile_info.dart';
import 'package:sbs_prototype/Screens/feedback_And_Rating.dart';
import 'package:sbs_prototype/Screens/homepageRepair.dart';
import 'package:sbs_prototype/Screens/my_book_noterbook.dart';
import 'package:sbs_prototype/Screens/profile_info.dart';
import 'package:sbs_prototype/Screens/repair_Book_Info.dart';
import 'package:sbs_prototype/Screens/sell_Donate.dart';
import 'package:sbs_prototype/Screens/send_For_Repair.dart';
import 'package:sbs_prototype/auth/firebase_auth_implemention/firebase_auth_services.dart';
import 'package:sbs_prototype/auth/signin.dart';
import 'package:sbs_prototype/auth/signin_repair_company.dart';
import 'package:sbs_prototype/auth/signup.dart';
import 'package:sbs_prototype/auth/firebase_options.dart';
import 'package:sbs_prototype/Screens/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '/signin',
      home: AuthChecker(),
      routes: {
        '/signin': (context) => Signin(),
        '/signup': (context) => Signup(),
        '/homepage': (context) => Homepage(),
        '/sellbook': (context) => SellBook(),
        '/getbook': (context) => GetBookNotebook(),
        '/mybooks': (context) => my_books_notebooks(),
        '/bookinfo': (context) => BookInfo(),
        '/editbookinfo': (context) => EditBookInfo(),
        '/profileinfo': (context) => ProfileInfo(),
        '/editprofileinfo': (context) => EditProfileInfo(),
        '/repairsignin': (context) => SigninRepair(),
        '/repairhomepage': (context) => HomepageRepair(),
        '/sendrepair': (context) => SendForRepair(),
        '/repairbookinfo': (context) => RepairBookInfo(),
        '/checkrepairs': (context) => check_repairs(),
        '/feedbackandrating': (context) => FeedbackAndRating(),
      },
    );
  }
}

class AuthChecker extends StatefulWidget {
  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() async {
    await _auth.checkCurrentUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
