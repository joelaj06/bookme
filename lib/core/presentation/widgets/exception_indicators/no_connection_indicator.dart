import 'package:bookme/core/presentation/utitls/app_assets.dart';
import 'package:flutter/cupertino.dart';

import 'exception_indicator.dart';

/// Indicates that a connection error occurred.
class NoConnectionIndicator extends StatelessWidget {
  const NoConnectionIndicator({
    Key? key,
    this.onTryAgain,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'No connection',
        message: 'Please check internet connection and try again.',
        assetName: AppImageAssets.noConnection,
        onTryAgain: onTryAgain,
      );
}
