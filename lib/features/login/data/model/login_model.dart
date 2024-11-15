import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';

Future<void> setUserInfoToCache(Map<String, dynamic> data) async {
  String dataJson = jsonEncode(data);
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString(cacheUserInfo, dataJson);
}

Future<Map<String, dynamic>?> getUserInfoFromCache() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  String? dataJson = sharedPreferences.getString(cacheUserInfo);

  if (dataJson != null) {
    return jsonDecode(dataJson) as Map<String, dynamic>;
  }

  return null;
}