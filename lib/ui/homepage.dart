import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/ui/numbersPage.dart';
import 'package:sano_manchey/ui/picturePage.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';

import 'alphabetsPage.dart';
import 'colorPage.dart';
import 'daysMonths.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AlphabetsPage()));
                  },
                  child: OptionTile(
                    title: ("Alphabets"),
                    image: ('assets/images/alphabets2.jpg'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NumberPage()));
                  },
                  child: OptionTile(
                    title: ("Numbers"),
                    image: ('assets/images/numbers.jpg'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ColorPage()));
                  },
                  child: OptionTile(
                    title: ("Colors"),
                    image: ('assets/images/colors.jpg'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DaysMonths()));
                  },
                  child: OptionTile(
                    title: ("Days & Months"),
                    image: ('assets/images/days.jpg'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PicturesPage()));
                  },
                  child: OptionTile(
                    title: ("Pictures"),
                    image: ('assets/images/pictures.jpg'),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: OptionTile(
                    title: ("Games"),
                    image: ('assets/images/games.jpg'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final String title;
  final String image;

  const OptionTile({Key key, this.title, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.boogaloo(
                fontSize: 36, color: white, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 180,
            width: 300,
            child: Card(
              elevation: 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset(image),
              ),
//                        Image.asset('assets/images/alphabets2.jpg')
            ),
          ),
        ],
      ),
    );
  }
}
