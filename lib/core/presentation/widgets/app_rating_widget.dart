import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
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
    return Container(
      padding: AppPaddings.mA.copyWith(
        top: 4,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        color: HintColor.color.shade50,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        children:  <Widget>[
           Icon(
            Icons.star,
            size: iconSize ?? 14,
            color: iconColor ?? Colors.orange,
          ),
          Text(value)
        ],
      ),
    );
  }
}
