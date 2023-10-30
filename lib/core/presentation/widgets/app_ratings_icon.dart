import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:flutter/material.dart';
class AppRatingsIcon extends StatelessWidget {
  const AppRatingsIcon({
    this.iconSize,
    Key? key, required this.ratings}) : super(key: key);

  final double ratings;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    final int ratingValue = ratings.round();
    return  Row(
      children: List<Widget>.generate(
        5,
            (int index) =>  Icon(
          Icons.star,
          size: iconSize ?? 14,
          color: index < ratingValue ? Colors.orange: HintColor.color.shade100,
        ),
      ),
    );
  }
}
