import 'package:flutter/material.dart';
import 'package:mobilesoftware/styles/styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context); // Go back to previous screen
              },
              icon: const Icon(Icons.arrow_back))),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/signupBackground.png'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              Text('Sign Up', style: Styles.titleStyle),
              const SizedBox(height: 30),
              _buildTextField(labelText: 'First name', obscureText: false),
              const SizedBox(height: 20),
              _buildTextField(labelText: 'Last name', obscureText: false),
              const SizedBox(height: 20),
              _buildTextField(labelText: 'Email', obscureText: false),
              const SizedBox(height: 20),
              _buildTextField(labelText: 'Password', obscureText: true),
              const SizedBox(height: 20),
              _buildTextField(
                  labelText: 'Confirm password', obscureText: true),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle: Styles.buttonTextStyle),
                onPressed: () {
                  //Implement sign-up logic
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    // Go to login screen.  Implement navigation
                  },
                  child: const Text('Already have any account? Sign In')),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextField(
      {required String labelText, required bool obscureText}) {
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