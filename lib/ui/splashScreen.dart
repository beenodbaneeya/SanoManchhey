import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/ui/landingPage.dart';
import 'package:sano_manchey/ui/signInPage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LandingPage())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: primaryColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/minion1.png'),
            Positioned(
              bottom: 280,
              left: 5,
              child: Text(
                "Sano Manchey",
                style: GoogleFonts.gloriaHallelujah(
                    color: white, fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 25,
              child: Container(
                width: 190,
                child: Column(
                  children: [
                    Text(
                      "Learning Platform for Kids",
                      style: GoogleFonts.gloriaHallelujah(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    LinearProgressIndicator(
                      minHeight: 2,
                      backgroundColor: white,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
