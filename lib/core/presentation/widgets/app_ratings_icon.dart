import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:flutter/material.dart';
class AppRatingsIcon extends StatelessWidget {
  const AppRatingsIcon({
    this.iconSize,
    Key? key, required this.ratings}) : super(key: key);

  final int ratings;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: List<Widget>.generate(
        5,
            (int index) =>  Icon(
          Icons.star,
          size: iconSize ?? 14,
          color: index < ratings ? Colors.orange: HintColor.color.shade100,
        ),
      ),
    );
  }
}
