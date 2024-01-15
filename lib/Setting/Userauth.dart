import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthManager {
  static const String _UserIdKey = 'UserId';

  // 사용자 이메일 정보 저장
  static Future<void> saveUserId(String UserId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_UserIdKey, UserId);
  }

  // 현재 로그인한 사용자 이메일 가져오기
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_UserIdKey);
  }

  // 로그아웃
  static Future<String?> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_UserIdKey);
  }
}