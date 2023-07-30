

import 'dart:io';

import 'package:flutter/foundation.dart';

const String baseUrlLocal = 'http://10.0.2.2:3000/api/';
const String baseUrl = 'https://bookme-vfk0.onrender.com/api/';

enum Environment { development, production }

bool isTesting = kIsWeb? false:Platform.environment.containsKey('FLUTTER_TEST');

const String _env =
String.fromEnvironment('env.mode', defaultValue: 'dev');

Environment get environment {
  const Map<String, Environment> _envs = <String, Environment>{
    'dev': Environment.development,
    'prod': Environment.production,
  };

  if (!_envs.containsKey(_env)) {
    throw Exception(
        "Invalid runtime environment: '$_env'. Available environments: ${_envs.keys.join(', ')}");
  }

  return _envs[_env]!;
}

extension EnvironmentX on Environment {

  bool get isDev => this == Environment.development;

  bool get isProduction => this == Environment.production;

  bool get isDebugging {
    bool condition = false;
    assert(() {
      condition = true;
      return condition;
    }());
    return condition;
  }

  String get value {
    return <Environment, String>{
      Environment.development: 'DEV',
      Environment.production: 'PROD',
    }[this]!;
  }

  String get url {
    return <Environment, String>{
      Environment.development: baseUrl,
      Environment.production: baseUrl,
    }[this]!;
  }
}