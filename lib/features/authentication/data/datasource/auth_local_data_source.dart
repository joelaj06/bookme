import 'dart:async';

import '../../../../core/utitls/shared_preferences_wrapper.dart';
import '../../../../core/utitls/shared_prefs_keys.dart';
import '../models/response/login/login_response.dart';


abstract class AuthLocalDataSource {
  LoginResponse? get authResponse;

  Future<void> deleteAuthResponse();

  Future<LoginResponse?> getAuthResponse();

  Future<void> persistAuthResponse(LoginResponse token);

  Future<bool> isAuthenticated();

}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._preferencesWrapper);

  final SharedPreferencesWrapper _preferencesWrapper;

  @override
  LoginResponse? authResponse;

  @override
  Future<void> deleteAuthResponse() async {
    await _preferencesWrapper.remove(SharedPrefsKeys.loginResponse);
    authResponse = null;
  }

  @override
  Future<LoginResponse?> getAuthResponse() async {
    final Map<String, dynamic>? json =
        await _preferencesWrapper.getMap(SharedPrefsKeys.loginResponse);
    if (json != null) {
      return authResponse = LoginResponse.fromJson(json);
    }
    return null;
  }

  @override
  Future<bool> isAuthenticated() async {
    final LoginResponse? response = await getAuthResponse();
    if (response != null) {
      return true;
    }
    await deleteAuthResponse();
    return false;
  }

  @override
  Future<void> persistAuthResponse(LoginResponse response) async {
    authResponse = response;
    await _preferencesWrapper.setMap(
      SharedPrefsKeys.loginResponse,
      authResponse!.toJson(),
    );
  }


}
