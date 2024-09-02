import 'package:flutter/material.dart';
import 'package:sbs_prototype/models/repair_model.dart';
import 'package:sbs_prototype/widgets/ReadOnlyStarRating.dart';

class SecondRepairBookCard extends StatefulWidget {
  final RepairModel book;

  const SecondRepairBookCard({required this.book});

  @override
  _SecondRepairBookCardState createState() => _SecondRepairBookCardState();
}

class _SecondRepairBookCardState extends State<SecondRepairBookCard> {
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
                  widget.book.ownerName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222831),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Damage Description: ' + widget.book.description,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF31363F),
              ),
            ),
            SizedBox(height: 4.0),
            ReadOnlyStarRating(
              rating: widget.book.rating.toDouble(),
            ),
            Text(
              'Feedback: ' + widget.book.feedback,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF31363F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
