import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(style: TextStyle(), children: <TextSpan>[
      TextSpan(
          text: 'Sano',
          style: GoogleFonts.boogaloo(
              fontWeight: FontWeight.w700, color: white, fontSize: 28)),
      TextSpan(
          text: 'Manchey',
          style: GoogleFonts.boogaloo(
              fontWeight: FontWeight.bold, color: white, fontSize: 32))
    ]),
  );
}
