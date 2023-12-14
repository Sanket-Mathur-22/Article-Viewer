import 'package:flutter/material.dart';

Widget customTextField(
    {String? title,
    String? hint,
    icon,
    controller,
    TextInputType,
    bool? value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title!,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        width: 350,
        padding: EdgeInsets.only(left: 15, right: 20, top: 0, bottom: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 2.5, color: Colors.amber)),
        child: TextField(
          keyboardType: TextInputType,
          controller: controller,
          decoration: InputDecoration(
            icon: icon,
            border: InputBorder.none,
            hintText: hint,
          ),
        ),
      ),
    ],
  );
}
