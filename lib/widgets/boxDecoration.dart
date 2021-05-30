import 'package:flutter/material.dart';
import 'package:sano_manchey/services/colors.dart';

BoxDecoration myBoxDecoration(BuildContext context) {
  return BoxDecoration(
      gradient: RadialGradient(
          colors: [white, primaryColor, darkAccentColor],
          center: Alignment(0.6, -0.3),
          focal: Alignment(0.3, -0.3)));
}
