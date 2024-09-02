/* /* import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final double? width;
  final double? height;
  final Color color;

  const CustomButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.width,
    this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: width ?? 300.0,
      height: height ?? 50.0,
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          
        ),
        
        child: Text(
          buttonText,
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
 */
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final IconData? iconData; // Icon data for the icon
  final double? width;
  final double? height;
  final Color color;

  const CustomButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.iconData, // Pass icon data to the constructor
    this.width,
    this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: width ?? 300.0,
      height: height ?? 50.0,
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        // Row to display the icon and the text
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) // Conditionally add the icon
              Icon(iconData, color: Color(0xFFEEEEEE)),
            SizedBox(width: 8), // Add some spacing between icon and text
            Text(
              buttonText,
              style: TextStyle(
                color: Color(0xFFEEEEEE),
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? buttonText;
  final Widget? icon; // Icon data for the icon
  final double? width;
  final double? height;
  final Color color;

  const CustomButton({
    Key? key,
    this.onPressed,
    this.buttonText,
    this.icon, // Pass icon data to the constructor
    this.width,
    this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: width ?? 300.0,
      height: height ?? 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        // Center the icon or the text
        child: Center(
          child: buttonText != null
              ? Text(
                  buttonText!,
                  style: TextStyle(
                    color: Color(0xFFEEEEEE),
                    fontSize: 18.0,
                  ),
                )
              : icon != null
                  ? icon
                  : Container(), // Display nothing if both are null
        ),
      ),
    );
  }
}
