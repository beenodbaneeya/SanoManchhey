import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';

import 'daysPage.dart';
import 'monthsPage.dart';

class DaysMonths extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: primaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: myBoxDecoration(context),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DaysPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10.0,
                      child: Container(
                        height: 200,
                        width: 250,
                        decoration: BoxDecoration(color: primaryColor),
                        child: Center(
                          child: Text(
                            'Days',
                            style: GoogleFonts.boogaloo(
                                fontWeight: FontWeight.bold,
                                fontSize: 56.0,
                                color: accentColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MonthsPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10.0,
                      child: Container(
                        decoration: BoxDecoration(color: primaryColor),
                        height: 200,
                        width: 250,
                        child: Center(
                          child: Text(
                            'Months',
                            style: GoogleFonts.boogaloo(
                                fontWeight: FontWeight.bold,
                                fontSize: 56.0,
                                color: accentColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
