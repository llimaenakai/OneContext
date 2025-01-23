import 'package:flutter/material.dart';

class Styles {
  // --- Color Definitions ---
  static const Color primaryColor = Color(0xFF0066CC); // Deep Blue as primary color
  static const Color secondaryColor = Color(0xFFFFFFFF); // White as secondary color
  static const Color accentColor = Color(0xFFFFA500); // Vibrant Orange for accents (buttons, highlights)
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light Gray for background (Day Mode)
  static const Color cardColor = Colors.white; // White for card background
  static const Color borderColor = Color(0xFFDDDDDD); // Light gray border color
  static const Color disabledColor = Color(0xFFBDBDBD); // Disabled state color
  static const Color errorColor = Color(0xFFB00020); // Red for error messages

  // --- Text Style Definitions ---
  static const TextStyle titleStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFFFFFFFF)); // White color for title (secondary color)

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: primaryColor, // Deep Blue for subtitles
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
    height: 1.5,
  );

  static const TextStyle inputLabelStyle = TextStyle(
    fontSize: 16,
    color: accentColor, // Vibrant orange for input labels
  );

  static const TextStyle inputTextStyle = TextStyle(
    fontSize: 18,
    color: secondaryColor, // White text for input fields
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white, // White text for buttons
  );

  static const TextStyle errorTextStyle = TextStyle(
    fontSize: 14,
    color: errorColor,
    fontWeight: FontWeight.w400,
  );

  // --- Button Style Definitions ---
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    textStyle: buttonTextStyle,
  ).copyWith(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor;
        }
        return primaryColor;
      },
    ),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    textStyle: buttonTextStyle,
  ).copyWith(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor;
        }
        return secondaryColor;
      },
    ),
  );

  static ButtonStyle disabledButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: disabledColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
  );
}
