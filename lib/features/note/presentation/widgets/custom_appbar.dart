import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? firstIcon;
  final IconData? secondIcon;
  final Color? colorText;
  final VoidCallback? onFirstIconPressed;
  final VoidCallback? onSecondIconPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.firstIcon,
    this.secondIcon,
    this.colorText,
    this.onFirstIconPressed,
    this.onSecondIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: firstIcon != null
          ? IconButton(
              icon: Icon(firstIcon),
              onPressed: onFirstIconPressed ?? () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colorText ?? Colors.black,
        ),
      ),
      actions: [
        if (secondIcon != null)
          IconButton(
            icon: Icon(secondIcon),
            onPressed: onSecondIconPressed ?? () {},
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
