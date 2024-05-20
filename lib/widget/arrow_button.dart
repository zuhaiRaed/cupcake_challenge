import 'package:cupcake_challenge/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArrowButton extends StatelessWidget {
  final bool isForward;
  final VoidCallback? onPressed;

  const ArrowButton({super.key, required this.isForward, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onDoubleTap: () {
        HapticFeedback.lightImpact();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Style.filledBackground,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isForward
              ? Icons.arrow_forward_ios_rounded
              : Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
