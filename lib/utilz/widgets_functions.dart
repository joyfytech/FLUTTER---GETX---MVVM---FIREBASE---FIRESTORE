import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

buildTextFun(BuildContext context, String title, {required double fontSize, required FontWeight fontWeight, required MaterialColor color}) {
  return Text(
    title, style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color
  ),

  );
}

TextFormField buildTextFormField({
  required TextEditingController controller,
  required String labelText,

}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(),
    ),

  );
}


buildSizedBoxHeightFun(BuildContext context, {required double height}) {
  return SizedBox(
    height: height,
  );
}
