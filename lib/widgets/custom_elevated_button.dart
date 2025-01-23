import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  const CustomElevatedButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        foregroundColor: MaterialStateProperty.all(Colors.white),
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