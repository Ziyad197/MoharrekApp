// Dart imports:
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

// Package imports:import 'package:shared_preferences/shared_preferences.dart';

/* global class for handle all the preference activity into application */
//flutter pub add shared_preferences
class Preference {
  static const String _userID = "userID";
  static const String _userAdmin = "_userAdmin";
  static const String _userPhone = "_userPhone";
  static const String _userName = "userName";

  // ------------------ SINGLETON -----------------------
  static final Preference _preference = Preference._internal();

  factory Preference() {
    return _preference;
  }

  Preference._internal();

  static Preference get shared => _preference;

  static SharedPreferences? _pref;

  /* make connection with preference only once in application */
  Future<SharedPreferences?> instance() async {
    if (_pref != null) return _pref;
    await SharedPreferences.getInstance().then((onValue) {
      _pref = onValue;
    }).catchError((onError) {
      _pref = null;
    });

    return _pref;
  }

  // String get & set
  String? getUserId() {
    return _pref!.getString(_userID) ?? '';
  }
  bool? getAdmin() {
    return _pref!.getBool(_userAdmin) ?? false;
  }
  String? getUserPhone() {
    return _pref!.getString(_userPhone) ?? '';
  }
  String? getUserName() {
    return _pref!.getString(_userName) ??'';
  }

  Future<bool> setUserId(String value) {
    return _pref!.setString(_userID, value);
  }
  Future<bool> setUserAdmin(bool value) {
    return _pref!.setBool(_userAdmin, value);
  }
  Future<bool> setUserPhone(String value) {
    return _pref!.setString(_userPhone, value);
  }
  Future<bool> setUserName(String value) {
    return _pref!.setString(_userName, value);
  }

  Future<bool> signOut() async {
    return await _pref!.clear();
  }
}