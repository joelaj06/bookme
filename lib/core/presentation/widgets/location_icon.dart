import 'package:flutter/material.dart';

import '../utitls/app_spacing.dart';
class LocationIcon extends StatelessWidget {
   LocationIcon({required this.text,
     this.textColor,
     this.iconColor,
     Key? key}) : super(key: key);

  String text;
  Color? iconColor;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return   Row(
      children:  <Widget>[
         Icon(
          Icons.place_outlined,
          size: 16,
          color: iconColor,
        ),
        const AppSpacing(
          h: 5,
        ),
        Text(text,
        style: TextStyle(
          color: textColor,
        ),)
      ],
    );
  }
}
