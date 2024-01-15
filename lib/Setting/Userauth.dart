import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthManager {
  static const String _EmailKey = 'Email';

  // 사용자 이메일 정보 저장
  static Future<void> saveEmail(String Email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_EmailKey, Email);
  }

  // 현재 로그인한 사용자 이메일 가져오기
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_EmailKey);
  }

  // 로그아웃
  static Future<String?> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_EmailKey);
  }

  static Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }
}