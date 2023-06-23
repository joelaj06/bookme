import 'package:flutter/cupertino.dart';

import 'exception_indicator.dart';

class GenericErrorIndicator extends StatelessWidget {
  const GenericErrorIndicator({
    Key? key,
    this.onTryAgain,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'Something went wrong',
        message: 'The application has encountered an unknown error.\n'
            'Please try again later.',
        assetName: 'assets/images/confused-face.png',
        onTryAgain: onTryAgain,
      );
}
