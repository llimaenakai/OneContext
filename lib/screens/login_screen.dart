import 'package:flutter/material.dart';
import 'package:mobilesoftware/styles/styles.dart';
import 'package:mobilesoftware/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                  Text('Login Name', style: Styles.titleStyle),
                  const SizedBox(height: 20),
                  _buildTextField(labelText: 'User Name', obscureText: false),
                  const SizedBox(height: 20),
                  _buildTextField(labelText: 'Password', obscureText: true),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Styles.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                      textStyle: Styles.buttonTextStyle,
                    ),
                    onPressed: () {
                      // Navigate to HomeScreen and clear LoginScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: const Text('Login'),
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
  }) {
    return TextFormField(
      style: Styles.inputTextStyle,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Styles.inputLabelStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        filled: true,
        fillColor: Styles.secondaryColor,
      ),
      obscureText: obscureText,
    );
  }
}
