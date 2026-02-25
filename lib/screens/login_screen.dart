import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesoftware/core/providers/auth_provider.dart';
import 'package:mobilesoftware/core/utils/constants.dart';
import 'package:mobilesoftware/widgets/custom_elevated_button.dart';
import 'package:mobilesoftware/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: _buildLoginForm(context),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildLogo(context),
        const SizedBox(height: 20),
        _buildLoginNameText(context),
        const SizedBox(height: 20),
        CustomTextFormField(
          labelText: 'User Name',
          obscureText: false,
          inputType: LoginInputType.email,
          controller: _usernameController,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          labelText: 'Password',
          obscureText: true,
          inputType: LoginInputType.password,
          controller: _passwordController,
        ),
        const SizedBox(height: 10),
        _buildLoginButtonSection(context),
        const SizedBox(height: 10),
        _buildSignUpButton(context),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Image.asset(
      "lib/assets/images/logo.png",
      height: MediaQuery.of(context).size.height * 0.2,
    );
  }

  Widget _buildLoginNameText(BuildContext context) {
    return Text(
      'Login Name',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
          ),
    );
  }

  Widget _buildLoginButtonSection(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Column(
          children: [
            // ... error message text ...
            CustomElevatedButton(
              // Reusing CustomElevatedButton
              text: 'Login', // **Ensure 'text' parameter is provided**
              loading: authProvider.isLoading,
              onPressed: authProvider.isLoading ? null : _performLogin,
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 10)),
                  ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/signup'); // Navigate to the signup screen
      },
      child: Text(
        'Don’t have an account? Sign Up',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Future<void> _performLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _message =
            "Please enter both username and password."; // Set local error message
      });
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final loginSuccess = await authProvider.login(username, password);

    if (loginSuccess) {
      print("Login Successful!");
      context.replaceNamed('home'); // Navigate to Home Screen on success
    } else {
      print("Login Failed");
      setState(() {
        _message = authProvider.errorMessage ??
            "Login Failed."; // Display error message, prioritize provider message
      });
    }
  }
}