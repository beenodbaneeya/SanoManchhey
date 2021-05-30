import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';

import 'homepage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: primaryColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/minion2.png'),
            Positioned(
                bottom: 150,
                child: Text(
                  "Welcome Sano Manchey!",
                  style: GoogleFonts.boogaloo(
                      color: white, fontSize: 26, fontWeight: FontWeight.bold),
                )),
            Positioned(
                bottom: 90,
                child: Material(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 40,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text('Go To Home',
                        style: GoogleFonts.freckleFace(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: white)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
