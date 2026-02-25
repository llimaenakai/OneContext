import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesoftware/core/utils/constants.dart';
import 'package:mobilesoftware/helpers/database_helper.dart';
import 'package:mobilesoftware/widgets/custom_text_form_field.dart';
import 'package:mobilesoftware/widgets/custom_elevated_button.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = <String, dynamic>{};
  String _message = '';
  bool _isLoading = false;
  bool _obscureText = true;
  String? _selectedRole;
  List<String>? _roles;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadUserRoles();
  }

  Future<void> _loadUserRoles() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      final dbHelper = DatabaseHelper();
      _roles = await dbHelper.getDistinctUserRoles();
      if (_roles == null || _roles!.isEmpty) {
        _errorMessage = "No user roles found in database.";
      }
    } catch (e) {
      _errorMessage = 'Failed to load user roles: $e';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
        _message = '';
      });

      try {
        final dbHelper = DatabaseHelper();
        final hashedPassword = await dbHelper.hashPassword(_formData[LoginFormKeys.password.key]);

        final userId = await dbHelper.insertRecord('users', {
          'username': _formData[LoginFormKeys.email.key],
          'password_hash': hashedPassword,
          'role': _selectedRole,
        });

        if (userId > 0) {
          _showSuccessMessage('User added successfully!');
          await Future.delayed(const Duration(seconds: 2));
          if (mounted) {
            context.goNamed('users'); // Using goNamed for navigation
          }
        } else {
          _showErrorMessage('Failed to add user to database.');
        }
      } catch (e) {
        _showErrorMessage('Database error: ${e.toString()}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      _showErrorMessage('Please fill in all required fields correctly.');
    }
  }

  void _showSuccessMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void _showErrorMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Add new user', style: TextStyle(color: Colors.black)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => context.pop(),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(constraints.maxWidth * 0.1),
          child: _buildForm(context),
        );
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildScreenTitle(),
          SizedBox(height: 24),
          CustomTextFormField(
            labelText: 'User Name',
            inputType: LoginInputType.email,
            onSaved: (value) => _formData[LoginFormKeys.email.key] = value,
            validator: _validateUsername,
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Password',
            inputType: LoginInputType.password,
            obscureText: _obscureText,
            onSaved: (value) => _formData[LoginFormKeys.password.key] = value,
            validator: _validatePassword,
            suffixIcon: IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.black),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            ),
          ),
          SizedBox(height: 16),
          _buildRoleDropdown(),
          SizedBox(height: 24),
          CustomElevatedButton(
            onPressed: _isLoading ? null : _addUser,
            text: 'Add User',
            loading: _isLoading,
          ),
          SizedBox(height: 16),
          _buildMessageText(),
        ],
      ),
    );
  }

  Widget _buildScreenTitle() {
    return Text(
      'Please add user to database',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildRoleDropdown() {
    if (_isLoading) {
      return const CircularProgressIndicator();
    }
    if (_errorMessage.isNotEmpty) {
      return Text(
        _errorMessage,
        style: const TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      );
    }
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'User Role',
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        filled: true,
        fillColor: Colors.white,
      ),
      isExpanded: true, // Added isExpanded: true
      value: _selectedRole,
      items: _roles?.map((role) => DropdownMenuItem(value: role, child: Text(role, style: const TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis)))).toList() ?? [], // Added overflow: TextOverflow.ellipsis
      onChanged: (String? newValue) => setState(() {
        _selectedRole = newValue;
        _formData['role'] = newValue;
      }),
      validator: (value) => value == null || value.isEmpty ? 'Please select a user role' : null,
      onSaved: (value) => _formData['role'] = value,
    );
  }

  Widget _buildMessageText() {
    return Text(
      _message,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.red),
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Please add user name";
    }
    if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value)) {
      return "Invalid Username format (use email)";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please provide password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}