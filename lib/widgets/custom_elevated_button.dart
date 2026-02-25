import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final ButtonStyle? style; // Optional custom ButtonStyle

  // **Static default style for CustomElevatedButton**
  static final ButtonStyle defaultStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, // Default background color
    foregroundColor: Colors.white, // Default foreground color (text color)
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Default shape
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20), // Default padding
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Default text style
  ).copyWith(
    // Resolve background color for disabled state
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey; // Default disabled color (you can customize)
        }
        return Colors.blue; // Default enabled color
      },
    ),
  );

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.style, // Optional custom style, if null, defaultStyle will be used
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ?? defaultStyle, // Use provided style or defaultStyle
      onPressed: loading ? null : onPressed,
      child: loading
          ? const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white,),
        ) ,
      )
          : Text(text),
    );
  }
}