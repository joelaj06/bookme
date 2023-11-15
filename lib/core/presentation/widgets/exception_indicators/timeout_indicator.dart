import 'package:bookme/core/presentation/utitls/app_assets.dart';
import 'package:flutter/cupertino.dart';

import 'exception_indicator.dart';

/// Indicates that a connection timeout error occurred.
class RequestTimeoutIndicator extends StatelessWidget {
  const RequestTimeoutIndicator({
    Key? key,
    this.onTryAgain,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
    title: 'Request Timeout',
    message: 'The app took too long to load',
    assetName: AppImageAssets.timeOut,
    onTryAgain: onTryAgain,
  );
}
