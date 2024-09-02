import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final double? width;
  final double? height;
  final bool emailThings;

  const CustomTextField({
    Key? key,
    this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    required this.obscureText,
    required this.enabled,
    this.width,
    this.height,
    this.emailThings = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      width: width ?? 320.0,
      height: height ?? 55.0,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        enabled: enabled,
        inputFormatters: [
          emailThings
              ? LengthLimitingTextInputFormatter(9)
              : LengthLimitingTextInputFormatter(255),
        ],
        decoration: InputDecoration(
          suffixText: emailThings ? '@uopstd.edu.jo' : '',
          suffixStyle: TextStyle(
            color: Color(0x000000).withOpacity(0.9),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: !enabled ? Colors.grey : Color(0x000000).withOpacity(0.9),
            fontSize: 18.0,
          ),
          filled: true,
          fillColor: Color(0x00FFFEFE).withOpacity(0.9),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          // ignore: unnecessary_null_comparison
          prefixIcon: prefixIcon != null
              ? IconTheme(
                  data: IconThemeData(
                    color: enabled
                        ? Color(0x000000).withOpacity(0.6)
                        : Colors
                            .grey, // Change prefix icon color based on enabled state
                  ),
                  child: prefixIcon!,
                )
              : null,

          /*  contentPadding: EdgeInsets.symmetric(
          vertical: 15.0,
          ),  */ //Adjust the vertical padding
        ),
        style: TextStyle(
            color: !enabled ? Colors.grey : Color(0x000000).withOpacity(0.9),
            fontSize: 18.0,
            fontWeight: FontWeight.bold),
        keyboardType: keyboardType,
      ),
    );
  }
}
