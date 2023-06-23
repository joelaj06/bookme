import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Oops! You are viewing an error.',
            style: theme.headline6!.copyWith(height: 1.5),
          ),
          TextSpan(text: '  —  ', style: theme.subtitle1),
          TextSpan(
            text: 'Peace Out!',
            style: theme.subtitle1!.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
