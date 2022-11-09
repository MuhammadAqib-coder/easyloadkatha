import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.child, required this.onPressed})
      : super(key: key);
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
