import 'package:flutter/material.dart';
import 'package:sbs_prototype/auth/firebase_auth_implemention/firebase_auth_services.dart';
import 'package:sbs_prototype/models/repair_model.dart';
import 'package:sbs_prototype/widgets/ThirdBookCard.dart';

class HomepageRepair extends StatefulWidget {
  const HomepageRepair({Key? key}) : super(key: key);

  @override
  _HomepageRepairState createState() => _HomepageRepairState();
}

class _HomepageRepairState extends State<HomepageRepair> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  late Future<List<RepairModel>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = RepairModel.getAllRepairs(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
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
            /* title: Text(
              'SBS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Color(0xFF222831),
              ),
            ), */
            leading: IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {
                //_auth.signOut(context);
                //_showFilterDialog();
                Navigator.of(context).pushNamed('/feedbackandrating');
                // _auth.checkCurrentUser(context);
              },
            ),
            backgroundColor: Color(0xFF76ABAE),
            centerTitle: true,
          ),
          backgroundColor: Color(0xFF222831),
          endDrawer: IconButton(
            icon: const Icon(Icons.exit_to_app),
            color: Colors.white,
            onPressed: () {
              _auth.signOut(context);
              //_showFilterDialog();
              //Navigator.of(context).pushReplacementNamed('/signin');
              // _auth.checkCurrentUser(context);
            },
          ),
          body: FutureBuilder<List<RepairModel>>(
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
                List<RepairModel> books = snapshot.data!;
                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return ThirdBookCard(book: books[index]);
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
        ),
        onWillPop: () async => false);
  }
}
