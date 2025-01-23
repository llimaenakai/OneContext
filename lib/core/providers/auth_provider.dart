import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:mobilesoftware/helpers/database_helper.dart';
import 'package:logger/logger.dart';
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
        'email': email,
        'password_hash': hashedPassword,
        'role': 'user', // Default role
      });

      return true;
    } catch (e) {
      _logger.e("Signup error:", error:e);
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
        if (BCrypt.checkpw(password, user.passwordHash)) {
          _loggedInUser = user;
          notifyListeners();
          _authService.saveLoginState(username, password);
          _setIsLoading(false);
          return true;
        } else {
          _setErrorMessage('Incorrect password.');
        }
      } else {
        _setErrorMessage('User not found.');
      }
    } catch (e) {
      _logger.e("Login error:", error:e);
      _setErrorMessage('An unexpected error occurred during login.');
    } finally {
      _setIsLoading(false);
    }
    return false;
  }

  Future<void> logout() async {
    _loggedInUser = null;
    notifyListeners();
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