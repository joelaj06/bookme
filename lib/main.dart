import 'dart:async';

import 'package:bookme/core/presentation/app/bookmeapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart' as level;

import 'package:logging/src/logger.dart';

import 'core/error_handling/error_boundary.dart';
import 'core/error_handling/error_reporter.dart';
import 'core/presentation/widgets/error_view.dart';
import 'core/utitls/app_log.dart';
import 'core/utitls/environment.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background,
  // such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  debugPrint('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final String? token = await FirebaseMessaging.instance.getToken();

  //This function will be called if notification is opened when app is
  // running in background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (navigator.currentState != null &&
        navigator.currentState?.context != null) {
      Navigator.pushNamed(
        navigator.currentState!.context,
        message.data['route'].toString(),
      );
    }
  });

  // This function will be called when app is terminated or closed
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    //todo handle notification navigation
    print('onBackgroundMessage: $message');
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
    child: BookMeApp(
      token: token,
    ),
  );
}

class _ReporterClient implements ReporterClient {
  _ReporterClient();

  @override
  FutureOr<void> report(
      {required StackTrace stackTrace,
      required Object error,
      Object? extra}) async {
    // TODO: Sentry or Crashlytics
  }

  @override
  void log(Object object) {
    AppLog.i(object);
  }
}
