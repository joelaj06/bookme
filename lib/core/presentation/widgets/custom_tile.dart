import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:flutter/material.dart';

import '../utitls/app_padding.dart';
import '../utitls/app_spacing.dart';


class CustomTile extends StatelessWidget {
  const CustomTile({
    Key? key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.hideMoreIcon = false,
    this.textColor,
    this.iconColor,
    this.backgroundColor,
    this.moreIconColor,
    this.showDivider,
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool hideMoreIcon;
  final Color? textColor;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? moreIconColor;
  final bool? showDivider;

  @override
  Widget build(BuildContext context) {
    final bool viewDivider = showDivider ?? false;
    return Column(
      children: <Widget>[
        Container(
          decoration:  BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(8)
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: AppPaddings.lV,
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (icon == null)
                  const SizedBox.shrink()
                else
                  Icon(
                    icon,
                    size: 22,
                    color: iconColor ?? Colors.black,
                  ),
                const AppSpacing(h: 26),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.black87,
                  ),
                ),
                const Spacer(),
                if (hideMoreIcon)
                  const SizedBox.shrink()
                else
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: moreIconColor?? HintColor.color,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (viewDivider) const Divider(height: 0) else const SizedBox.shrink()
      ],
    );
  }
}
