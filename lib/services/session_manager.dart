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

void main() async {
  final sessionManager = SessionManager();
  await sessionManager.initialize(); // Initialize the session manager

  // Example usage
  final session = 'your_session_data';
  await sessionManager.saveSession(session);
  final savedSession = sessionManager.getSession();
  print(savedSession);
}