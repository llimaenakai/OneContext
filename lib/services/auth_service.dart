import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();

  // **2. Implement saveLoginState**
  Future<void> saveLoginState(String username, String password) async { // In real apps, avoid storing password
    await _storage.write(key: 'username', value: username); // For demonstration, storing username
    await _storage.write(key: 'password', value: password); // **Not Recommended for real apps**
    await _storage.write(key: 'isLoggedIn', value: 'true'); // Save login state flag
  }

  // **3. Implement checkLoginState**
  Future<bool> checkLoginState() async {
    String? isLoggedIn = await _storage.read(key: 'isLoggedIn');
    return isLoggedIn == 'true';
  }

  // **4. Implement clearLoginState**
  Future<void> clearLoginState() async {
    await _storage.deleteAll(); // Clear all stored login data
  }
}