// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../login_screen.dart';

class custom_text_field extends StatelessWidget {
  String labelTextField;
  String hintText;
  TextEditingController controller;
  Widget suffixIcon;
  Color suffixIconColor;
  custom_text_field({
    Key? key,
    required this.labelTextField,
    required this.hintText,
    required this.controller,
    required this.suffixIcon,
    required this.suffixIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kPrimaryColor,
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        labelText: labelTextField,
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
        ),
      ),
    );
  }
}
