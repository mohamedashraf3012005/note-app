import 'package:flutter/material.dart';

class CreateNewButton extends StatelessWidget {
  final String title;
  final IconData? firstIcon;
  final VoidCallback? onPressed;
  const CreateNewButton({
    super.key,
    required this.title,
    this.firstIcon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      color: const Color(0xFFFEFEFE),
      height: 75,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 45),
          Icon(
            firstIcon,
            fontWeight: FontWeight.bold,
            size: 30,
            color: Color(0xFF0F5AFE),
          ),
          const SizedBox(width: 18),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
