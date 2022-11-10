import 'package:flutter/material.dart';

class RichTwoPartsText extends StatelessWidget {
  final String rightPart;
  final String leftPart;
  const RichTwoPartsText({
    Key? key,
    required this.rightPart,
    required this.leftPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.white70,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: leftPart,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' $rightPart',
          )
        ],
      ),
    );
  }
}
