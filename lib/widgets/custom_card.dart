import 'package:flutter/material.dart';

Widget customcard({String? title}){
  return Card(
        //margin: const EdgeInsets.all(20),
        elevation: 5.0,
        color: Colors.amberAccent,
        child: SizedBox(
          width: 350,
          height: 50,
          child: ListTile(
            title: Text(title!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
          ),
        ),
      );
}