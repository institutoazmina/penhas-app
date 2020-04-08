import 'package:mastodon_dart/mastodon_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class stores the user's authorization token locally
/// via SharedPreferences
class AuthStorage extends AuthStorageDelegate {
  @override
  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

// "U7uYIjAlJ6eQZdWfcp0rs5-MQjMKXvGGcioBx3HVckg"
  @override
  Future<String> get fetchToken async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return token;
  }
}
