import 'package:flutter/material.dart';
import 'package:sbs_prototype/models/repair_model.dart';

class ThirdBookCard extends StatefulWidget {
  final RepairModel book;

  const ThirdBookCard({required this.book});
  @override
  _ThirdBookCardState createState() => _ThirdBookCardState();
}

class _ThirdBookCardState extends State<ThirdBookCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/repairbookinfo', arguments: {
          'id': widget.book.RepairId,
          'email': widget.book.email,
          'description': widget.book.description,
          'ownerName': widget.book.ownerName,
          'ownerPhone': widget.book.ownerPhone,
          'image': widget.book.image,
          'type': widget.book.type,
          'status': widget.book.status,
        });
      },
      child: Center(
        child: Container(
          //duration: Duration(milliseconds: 500),
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
                        width: 100, // Adjust width as needed
                        height: 100, // Adjust height as needed
                        child: widget.book.image != null &&
                                widget.book.image!.isNotEmpty
                            ? Image.network(widget.book.image!,
                                fit: BoxFit.cover)
                            : Icon(
                                Icons.image,
                                size: 55,
                                color: Color(0xFF76ABAE),
                              ), // Adjust icon size as needed
                      ),
                    ),
                  ),

                  // image code
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
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF31363F),
                ),
              ),
              /* 
              SizedBox(height: 10.0),
              Text(
                '${widget.book.type} In a ${widget.book.bookCondition} Condition',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF31363F),
                ),
              ),
              SizedBox(height: 8.0),
              widget.book.donate
                  ? Text(
                      'For Free (Donate)',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF31363F),
                      ),
                    )
                  : Text(
                      'Price: ${widget.book.price} JD',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF31363F),
                      ),
                    ),
              SizedBox(height: 4.0), */
            ],
          ),
        ),
      ),
    );
  }
}
