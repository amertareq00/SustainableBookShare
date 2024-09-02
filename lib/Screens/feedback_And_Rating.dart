import 'package:flutter/material.dart';
import 'package:sbs_prototype/models/repair_model.dart';
import 'package:sbs_prototype/widgets/SecondRepairBookCard.dart';

class FeedbackAndRating extends StatefulWidget {
  const FeedbackAndRating({Key? key}) : super(key: key);

  @override
  _FeedbackAndRatingState createState() => _FeedbackAndRatingState();
}

class _FeedbackAndRatingState extends State<FeedbackAndRating> {
  late Future<List<RepairModel>> _booksFuture;
  @override
  void initState() {
    super.initState();
    _booksFuture = RepairModel.getAllRepairs(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/repairhomepage');
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
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF76ABAE),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF222831),
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
                return SecondRepairBookCard(book: books[index]);
              },
            );
          } else {
            return Center(
              child: Text('ss'),
            );
          }
        },
      ),
    );
  }
}
