import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late final SharedPreferences sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required String key,
  }) {
    if(sharedPreferences.containsKey(key)){
      return sharedPreferences.get(key);
    }

    return null;
  }

  static Future<bool> removeData({
    required String key,
  }) {
    return sharedPreferences.remove(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic val,
  }) async {
    if (val is String) {
      return await sharedPreferences.setString(
        key,
        val,
      );
    }
    if (val is bool) {
      return await sharedPreferences.setBool(
        key,
        val,
      );
    }
    if (val is int) {
      return await sharedPreferences.setInt(
        key,
        val,
      );
    }

    return await sharedPreferences.setDouble(
      key,
      val,
    );
  }

  static Future<bool> deleteCacheData({required String key}) async {
    await sharedPreferences.remove(key);
    return true;
  }
}
