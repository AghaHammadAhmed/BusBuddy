import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save user session
  static Future<void> saveUserSession({
    required String userType,
    required String userId,
    String? name,
    String? email,
  }) async {
    await _prefs.setBool('isLoggedIn', true);
    await _prefs.setString('userType', userType);
    await _prefs.setString('userId', userId);
    if (name != null) await _prefs.setString('userName', name);
    if (email != null) await _prefs.setString('userEmail', email);
  }

  // Clear user session
  static Future<void> clearSession() async {
    await _prefs.clear();
  }

  // Get user data
  static Map<String, dynamic> getUserData() {
    return {
      'isLoggedIn': _prefs.getBool('isLoggedIn') ?? false,
      'userType': _prefs.getString('userType'),
      'userId': _prefs.getString('userId'),
      'userName': _prefs.getString('userName'),
      'userEmail': _prefs.getString('userEmail'),
    };
  }

  // Check if user is logged in
  static bool isUserLoggedIn() {
    return _prefs.getBool('isLoggedIn') ?? false;
  }

  // Get user type
  static String? getUserType() {
    return _prefs.getString('userType');
  }
}
<<<<<<< HEAD


=======
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
