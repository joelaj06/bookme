import 'dart:async';

import 'package:bookme/core/presentation/app/bookmeapp.dart';
import 'package:logging/logging.dart' as level;

import 'package:logging/src/logger.dart';

import 'core/error_handling/error_boundary.dart';
import 'core/error_handling/error_reporter.dart';
import 'core/presentation/widgets/error_view.dart';
import 'core/utitls/app_log.dart';
import 'core/utitls/environment.dart';

void main() {

  final ErrorReporter errorReporter = ErrorReporter(client: _ReporterClient());
  Logger.root.level = level.Level.ALL;
  Logger.root.onRecord.listen(
    logListener(
      onReleaseModeException: errorReporter.report,
    ),
  );
  ErrorBoundary(
    isReleaseMode: !environment.isDebugging,
    errorViewBuilder: (_) => const ErrorView(),
    onException: AppLog.e,
    child:  const BookMeApp(),
  );
}


class _ReporterClient implements ReporterClient {
  _ReporterClient();

  @override
  FutureOr<void> report({required StackTrace stackTrace,
    required Object error,
    Object? extra}) async {
    // TODO: Sentry or Crashlytics
  }

  @override
  void log(Object object) {
    AppLog.i(object);
  }
}
