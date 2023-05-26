import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _sessionKey = 'session';

  static SessionManager? _instance;
  SharedPreferences? _prefs;

  factory SessionManager() {
    if (_instance == null) {
      _instance = SessionManager._();
    }
    return _instance!;
  }

  SessionManager._();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveSession(String session) async {
    await _prefs!.setString(_sessionKey, session);
  }

  String? getSession() {
    return _prefs!.getString(_sessionKey);
  }

  Future<void> clearSession() async {
    await _prefs!.remove(_sessionKey);
  }
}
