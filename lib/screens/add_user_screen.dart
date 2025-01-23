import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesoftware/core/utils/constants.dart';
import 'package:mobilesoftware/helpers/database_helper.dart';
//import 'package:mobilesoftware/styles/styles.dart'; // Ensure this import is still here

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  String _message = '';
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new user',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(constraints.maxWidth * 0.1),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please add user to database',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _CustomTextFormField(
                      labelText: 'User Name',
                      inputType: LoginInputType.email,
                      onSaved: (value) {
                        _formData[LoginFormKeys.email.key] = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please add user name";
                        }
                        if (!RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                            .hasMatch(value)) {
                          return "Invalid Username format please use a valid email instead";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    _CustomTextFormField(
                      labelText: 'Password',
                      inputType: LoginInputType.password,
                      obscureText: _obscureText,
                      onSaved: (value) {
                        _formData[LoginFormKeys.password.key] = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide password for user';
                        }
                        if (value.length < 6) {
                          return 'Minimum 6 char password required';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _ElevatedButton(
                      onPressed: _isLoading ? null : _addUser,
                      text: 'Add User',
                      loading: _isLoading,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    Text(
                      _message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
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
        // **Security Improvement: Hash the password before inserting**
        final hashedPassword = await dbHelper.hashPassword(_formData[LoginFormKeys.password.key]);

        final userId = await dbHelper.insertRecord('users', {
          'username': _formData[LoginFormKeys.email.key],
          'password_hash': hashedPassword, // Use the hashed password
          'role': 'administrator',
        });
        if (userId > 0) {
          setState(() {
            _message = 'User added correctly!';
          });

          await Future.delayed(const Duration(seconds: 2));
          if (mounted) {
            context.pop();
          }
          return;
        } else {
          setState(() {
            _message = 'User was not added to database';
          });
        }
      } catch (e) {
        setState(() {
          _message = 'Error database insert implementation: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _message = 'Please fill the required data fields!';
      });
    }
  }
}

class _CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final LoginInputType inputType;
  final Widget? suffixIcon;

  const _CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.inputType,
    this.onSaved,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
      keyboardType: inputType == LoginInputType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
    );
  }
}

class _ElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  const _ElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blue),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
      onPressed: loading ? null : onPressed,
      child: loading
          ? const CircularProgressIndicator(
        color: Colors.white,
      )
          : Text(text),
    );
  }
}