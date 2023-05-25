import 'package:flutter/material.dart';

import '../utitls/app_spacing.dart';
class IconText extends StatelessWidget {
  const IconText({required this.text,
     this.textColor,
     this.iconColor,
     this.icon,
     Key? key}) : super(key: key);

  final String text;
  final Color? iconColor;
  final Color? textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return   Row(
      children:  <Widget>[
         Icon(
          icon ?? Icons.place_outlined,
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
