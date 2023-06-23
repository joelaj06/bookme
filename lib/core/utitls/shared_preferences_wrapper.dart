import 'dart:async' show Future;
import 'dart:convert' show json;

import 'package:shared_preferences/shared_preferences.dart';

import 'app_log.dart';

class SharedPreferencesWrapper {

  Future<String> getString(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  Future<String> setString(String key, String value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
    return value;
  }

  Future<Map<String, dynamic>?> getMap(String key) async {
    try {
      final String map = await getString(key);
      return map.isEmpty ? null : json.decode(map) as Map<String, dynamic>;
    } catch (e, st) {
      AppLog.e(e, st);
      return null;
    }
  }

  Future<Map<String, dynamic>?> setMap(
      String key, Map<String, dynamic> value) async {
    AppLog.i('Storing values');
    AppLog.i(json.encode(value));
    await setString(key, json.encode(value));
    return value;
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key);
  }

  Future<int> setInt(String key, int value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setInt(key, value);
    return value;
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setBool(key, value);
    return value;
  }

  Future<bool> contains(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
/*    if(key==SharedPrefsKeys.loginResponse) {
      return true;
    }*/
    return sharedPreferences.remove(key);
  }

  Future<bool> clear() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }
}
