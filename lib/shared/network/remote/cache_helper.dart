import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveDate(
      {required String key, required dynamic val}) async {
    if (val is String) {
      return await sharedPreferences!.setString(key, val);
    }
    if (val is int) {
      return await sharedPreferences!.setInt(key, val);
    }
    if (val is bool) {
      return await sharedPreferences!.setBool(key, val);
    }
    return await sharedPreferences!.setDouble(key, val);
  }

  static Future<bool> clearData({required String key})async {
    return await sharedPreferences!.remove(key);
  }
}
