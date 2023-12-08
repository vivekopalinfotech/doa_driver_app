// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String USER_ID = 'user_id';
  static const String USER_FIRST_NAME = 'user_first_name';
  static const String USER_LAST_NAME = 'user_last_name';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PHONE = 'user_phone';
  static const String USER_VEHICLE = 'user_vehicle';
  static const String USER_VEHICLE_COLOR = 'user_vehicle_color';
  static const String SET_LOCATION = 'set_location';
  static const String SET_LOGIN_CODE = 'set_login_code';
  static const String USER_TOKEN = 'user_token';
  static const String ONLINE = 'online';
}

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    _instance ??= SharedPreferencesService._internal();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }


  Future<void> setUserID(int userId) async =>
      await _preferences?.setInt(SharedPrefKeys.USER_ID, userId);

  int ? get userId => _preferences?.getInt(SharedPrefKeys.USER_ID);

  Future<void> setUserFirstName(String userName) async =>
      await _preferences?.setString(SharedPrefKeys.USER_FIRST_NAME, userName);

  String ? get userFirstName =>
      _preferences?.getString(SharedPrefKeys.USER_FIRST_NAME);

  Future<void> setUserLastName(String userName) async =>
      await _preferences?.setString(SharedPrefKeys.USER_LAST_NAME, userName);

  String ? get userLastName =>
      _preferences?.getString(SharedPrefKeys.USER_LAST_NAME);

  Future<void> setUserEmail(String userEmail) async =>
      await _preferences?.setString(SharedPrefKeys.USER_EMAIL, userEmail);

  String ? get userEmail => _preferences?.getString(SharedPrefKeys.USER_EMAIL);

  Future<void> setUserPhone(String userPhone) async =>
      await _preferences?.setString(SharedPrefKeys.USER_PHONE, userPhone);

  String ? get userPhone => _preferences?.getString(SharedPrefKeys.USER_PHONE);

  Future<void> setUserVehicle(String userVehicle) async =>
      await _preferences?.setString(SharedPrefKeys.USER_VEHICLE, userVehicle);

  String ? get userVehicle => _preferences?.getString(SharedPrefKeys.USER_VEHICLE);

  Future<void> setUserVehicleColor(String userVehicleColor) async =>
      await _preferences?.setString(SharedPrefKeys.USER_VEHICLE_COLOR, userVehicleColor);

  String ? get userVehicleColor => _preferences?.getString(SharedPrefKeys.USER_VEHICLE_COLOR);

  Future<void> setLocation(String postLocation) async =>
      await _preferences?.setString(SharedPrefKeys.SET_LOCATION, postLocation);

  String ? get postLocation => _preferences?.getString(SharedPrefKeys.SET_LOCATION);

  Future<void> setMobileCode(String loginCode) async =>
      await _preferences?.setString(SharedPrefKeys.SET_LOGIN_CODE, loginCode);

  String ? get loginCode => _preferences?.getString(SharedPrefKeys.SET_LOGIN_CODE);

  Future<void> setUserToken(String userToken) async =>
      await _preferences?.setString(SharedPrefKeys.USER_TOKEN, userToken);

  String ? get userToken => _preferences?.getString(SharedPrefKeys.USER_TOKEN);

  Future<void> setOnline(bool userOnline) async =>
      await _preferences?.setBool(SharedPrefKeys.ONLINE, userOnline);

  bool ? get userOnline => _preferences?.getBool(SharedPrefKeys.ONLINE);

  Future<void> logoutUser() async {
    _preferences?.remove(SharedPrefKeys.USER_ID);
    _preferences?.remove(SharedPrefKeys.USER_FIRST_NAME);
    _preferences?.remove(SharedPrefKeys.USER_LAST_NAME);
    _preferences?.remove(SharedPrefKeys.USER_EMAIL);
    _preferences?.remove(SharedPrefKeys.USER_PHONE);
    _preferences?.remove(SharedPrefKeys.USER_VEHICLE);
    _preferences?.remove(SharedPrefKeys.USER_VEHICLE_COLOR);
    _preferences?.remove(SharedPrefKeys.SET_LOGIN_CODE);
    _preferences?.remove(SharedPrefKeys.USER_TOKEN);

  }

  Future<void> clearLocation() async {
    _preferences?.remove(SharedPrefKeys.SET_LOCATION);
  }
}
