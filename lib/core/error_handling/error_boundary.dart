import 'dart:async' as async;

import 'package:flutter/widgets.dart';

class ErrorBoundary {
  ErrorBoundary({
    required Widget child,
    required Widget Function(FlutterErrorDetails details) errorViewBuilder,
    required void Function(Object error, StackTrace stackTrace) onException,
    required bool isReleaseMode,
  }) {
    if (isReleaseMode) {
      ErrorWidget.builder = errorViewBuilder;
    }

    FlutterError.onError = (FlutterErrorDetails details) async {
      if (isReleaseMode) {
        async.Zone.current.handleUncaughtError(
            details.exception, details.stack ?? StackTrace.current);
      } else {
        FlutterError.presentError(details);
      }
    };

    async.runZonedGuarded(() => runApp(child), onException);
  }
}
