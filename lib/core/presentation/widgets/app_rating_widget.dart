import 'package:flutter/material.dart';
class AppRating extends StatelessWidget {
  const AppRating({required this.value,
    this.iconColor,
    this.iconSize,
    Key? key}) : super(key: key);

  final String value;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  <Widget>[
         Icon(
          Icons.star,
          size: iconSize ?? 14,
          color: iconColor ?? Colors.orange,
        ),
        Text(value)
      ],
    );
  }
}
