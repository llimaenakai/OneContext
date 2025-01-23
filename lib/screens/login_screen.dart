import 'package:flutter/material.dart';
import 'package:mobilesoftware/screens/home_screen.dart'; // Keep for now, navigation will be handled differently later
import 'package:provider/provider.dart'; // Import Provider
import 'package:mobilesoftware/core/providers/auth_provider.dart'; // Import AuthProvider

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "lib/assets/images/logo.png",
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Login Name',
                    style: Theme.of(context).textTheme.titleLarge, // Use theme's titleLarge
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(labelText: 'User Name', obscureText: false, context: context), // Pass context
                  const SizedBox(height: 20),
                  _buildTextField(labelText: 'Password', obscureText: true, context: context), // Pass context
                  const SizedBox(height: 10),
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return Column(
                        children: [
                          if (authProvider.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                authProvider.errorMessage!,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith( // Use headline6 from theme for error
                                  color: Theme.of(context).colorScheme.error, // Ensure error color from theme
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style?.copyWith( // Use button theme
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 90, vertical: 10)),
                            ),
                            onPressed: authProvider.isLoading
                                ? null
                                : () async {
                              final username = _usernameController.text;
                              final password = _passwordController.text;
                              final loginSuccess = await authProvider.login(username, password);
                              if (loginSuccess) {
                                print("Login Successful!");
                              } else {
                                print("Login Failed");
                              }
                            },
                            child: authProvider.isLoading
                                ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                                : Text(
                              'Login',
                              style: Theme.of(context).textTheme.labelSmall, // Use button text style from theme
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign-Up Screen if implemented
                    },
                    child: const Text('Don\'t have any account? Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextField({
    required String labelText,
    required bool obscureText,
    required BuildContext context,
  }) {
    return TextFormField(
      controller: _usernameController, // Note: Still using _usernameController (should be based on labelText or more generic if reused)
      style: Theme.of(context).textTheme.bodyMedium, // Use theme's bodyText1
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.labelMedium, // Use theme's caption
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary, // Use theme's secondary color
      ),
      obscureText: obscureText,
    );
  }
}