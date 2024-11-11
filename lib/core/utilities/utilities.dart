import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';
import '../constants/constants.dart';

class Utilities {
  
  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  
  Future<void> setCacheData(String metaData) async {
    await sharedPreferences.setString(cacheUserRegistered, metaData);
    await sharedPreferences.setBool(cacheFlagRegistered, true);
  }

  String getDeviceData() {
    return sharedPreferences.getString(cacheUserRegistered) ?? "Error";
  }

  bool getFlagRegistered() {
    return sharedPreferences.getBool(cacheFlagRegistered) ?? false;
  }
}