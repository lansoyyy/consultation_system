import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalText extends StatelessWidget {
  late String label;
  late Color color;
  late double fontSize;

  NormalText(
      {required this.label, required this.fontSize, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(fontSize: fontSize, color: color),
      ),
    );
  }
}

class BoldText extends StatelessWidget {
  late String label;
  late Color color;
  late double fontSize;

  BoldText({required this.label, required this.fontSize, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.openSans(
        fontWeight: FontWeight.w900,
        textStyle: TextStyle(fontSize: fontSize, color: color),
      ),
    );
  }
}
