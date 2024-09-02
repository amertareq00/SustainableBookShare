import 'package:flutter/material.dart';

class CustomDescriptionField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;

  const CustomDescriptionField({
    Key? key,
    this.controller,
    this.hintText,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: 320.0,
      height: 100.0, // Adjust height according to your preference
      child: TextFormField(
        controller: controller,
        maxLines: 3, // Allows for multiple lines of input
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0x000000).withOpacity(0.9),
            fontSize: 18.0,
          ),
          filled: true,
          fillColor: Color(0x00FFFEFE).withOpacity(0.9),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
                BorderRadius.circular(10), // Adjust border radius as needed
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0, // Adjust horizontal padding as needed
          ),
        ),
        style: TextStyle(
          color: Color(0x000000).withOpacity(0.9),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
