import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  Future setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", value);
    print(value);
    if (pref.containsKey("token")) {
      print('berhasil disimpan');
    } else {
      print('gagal');
    }
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString("token");
  }

  Future setUserID(int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt("userID", value);
  }

  Future<int?> getUserID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("userID");
  }

  Future logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
