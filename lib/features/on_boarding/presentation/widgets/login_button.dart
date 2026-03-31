import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  const LoginButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 20,
      color: Colors.blue,
      textColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        width: 320,
        height: 50,
        child: Center(
          child: Text(
            title!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
