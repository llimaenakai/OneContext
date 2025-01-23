// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class AuthService {
//   final _storage = const FlutterSecureStorage();
//
//   Future<void> saveLoginState(String username, String password) async {
//     await _storage.write(key: 'username', value: username);
//     await _storage.write(key: 'password', value: password);
//     await _storage.write(key: 'isLoggedIn', value: 'true'); // Save login state
//   }
//
//   Future<bool> checkLoginState() async {
//     String? isLoggedIn = await _storage.read(key: 'isLoggedIn');
//     return isLoggedIn == 'true';
//   }
//
//   Future<void> clearLoginState() async {
//     await _storage.deleteAll(); // Clear all stored data
//   }
// }
