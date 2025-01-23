import 'package:flutter/material.dart';

// Padding values (use int if needed based on layout and implementation)
const double paddingSizeSmall = 8.0;
const double paddingSizeMedium = 16.0;
const double paddingSizeLarge = 24.0;
const double paddingSizeExtraLarge = 32.0;

// Theme Colors
const Color kPrimaryColor = Colors.black;
const Color kSecondaryColor = Colors.white; // If you set another secondary color for layouts, add it here
const Color kAccentColor = Colors.grey;

// Animation durations
const int kDefaultAnimationDuration = 200;

// App Name / Default string
const String kAppName = "Hafiz Usman Mobile Shop";

// Enums for specific data types or input format validation
enum LoginInputType {
  email,
  password,
}

// Public enum for form keys
enum LoginFormKeys {
  email,
  password,
}

// Extension to provide string keys for the LoginFormKeys enum
extension LoginFormKeysExtension on LoginFormKeys {
  String get key {
    switch (this) {
      case LoginFormKeys.email:
        return 'email';
      case LoginFormKeys.password:
        return 'password';
    }
  }
}

// Text styles
const TextStyle kTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kSecondaryColor,
);

const TextStyle kInputLabelStyle = TextStyle(
  fontSize: 16,
  color: kAccentColor,
);

const TextStyle kInputTextStyle = TextStyle(
  fontSize: 18,
  color: kSecondaryColor,
);

const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: kSecondaryColor,
);
