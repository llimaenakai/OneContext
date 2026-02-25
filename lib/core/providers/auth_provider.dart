import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobilesoftware/helpers/database_helper.dart';
import 'package:mobilesoftware/models/user.dart';
import 'package:mobilesoftware/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final _logger = Logger();
  User? _loggedInUser;
  final AuthService _authService = AuthService();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get loggedInUser => _loggedInUser;

  Future<bool> signup(String username, String email, String password) async {
    // Signup function remains mostly the same (you can review for audit logging later if needed)
    _setIsLoading(true);
    _setErrorMessage(null);

    try {
      final dbHelper = DatabaseHelper();
      final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

      final existingUser = await dbHelper.getUserByName(username);
      if (existingUser != null) {
        _setErrorMessage('Username is already taken.');
        return false;
      }

      await dbHelper.insertRecord('users', {
        'username': username,
        'email':
            email, // Assuming you want to store email as well during signup
        'password_hash': hashedPassword,
        'role': 'user', // Default role
      });

      return true;
    } catch (e) {
      _logger.e("Signup error:", error: e);
      _setErrorMessage('An unexpected error occurred during signup.');
    } finally {
      _setIsLoading(false);
    }
    return false;
  }

  Future<bool> login(String username, String password) async {
    _setIsLoading(true);
    _setErrorMessage(null);

    try {
      final dbHelper = DatabaseHelper();
      final User? user = await dbHelper.getUserByName(username);

      if (user != null) {
        // This line will check if the user exist in database or not
        if (BCrypt.checkpw(password, user.passwordHash)) {
          // the above line will check either password which is stored in hash form in our database are the same as we received just from the user right now if its true it enters into below body
          // **Login Successful!**

          // 1. Record Login Audit Log
          await dbHelper.insertRecord('audit_logs', {
            'user_id': user.id,
            'event_type': 'login',
          });

          // 2. Update loggedInUser and notify listeners
          _loggedInUser = user;
          notifyListeners();

          // 3. Save login state (optional - using AuthService)
          _authService.saveLoginState(username,
              password); // Consider if you still want to save password

          _setIsLoading(false);
          return true;
        } else {
          _setErrorMessage('Incorrect password.');
        }
      } else {
        _setErrorMessage('User not found.');
      }
    } catch (e) {
      _logger.e("Login error:", error: e);
      _setErrorMessage('An unexpected error occurred during login.');
    } finally {
      _setIsLoading(false);
    }
    return false;
  }

  Future<void> logout() async {
    // 1. Record Logout Audit Log
    if (_loggedInUser != null) {
      // Check if a user is logged in before logging out
      final dbHelper = DatabaseHelper();
      await dbHelper.insertRecord('audit_logs', {
        'user_id': _loggedInUser!.id, // Use loggedInUser's ID
        'event_type': 'logout',
        'logout_reason':
            'User initiated', // Or get reason dynamically if needed
      });
    }

    // 2. Clear loggedInUser and notify listeners
    _loggedInUser = null;
    notifyListeners();

    // 3. Clear login state (using AuthService)
    _authService.clearLoginState();
  }

  void _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }
}