import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/services/database.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AlphabetsPage extends StatefulWidget {
  @override
  _AlphabetsPageState createState() => _AlphabetsPageState();
}

class _AlphabetsPageState extends State<AlphabetsPage> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Alphabets');

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
        child: StreamBuilder(
          stream: collectionReference.orderBy('letterCapital').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return AlphabetTile(
                      letterSmall: snapshot.data.docs[index].get("letterSmall"),
                      letterCapital:
                          snapshot.data.docs[index].get("letterCapital"),
                      imageUrl: snapshot.data.docs[index].get("imageUrl"),
                      sentence: snapshot.data.docs[index].get("sentence"),
                    );
                  },
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AlphabetTile extends StatelessWidget {
  final String imageUrl;
  final String letterSmall;
  final String letterCapital;
  final String sentence;

  const AlphabetTile(
      {Key key,
      this.imageUrl,
      this.letterSmall,
      this.letterCapital,
      this.sentence})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: myBoxDecoration(context),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        letterCapital,
                        style: GoogleFonts.boogaloo(
                            fontSize: 96,
                            color: white,
                            shadows: <Shadow>[
                              Shadow(offset: Offset(3, 3), color: accentColor)
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        letterSmall,
                        style: GoogleFonts.boogaloo(
                            fontSize: 76,
                            color: white,
                            shadows: <Shadow>[
                              Shadow(offset: Offset(3, 3), color: accentColor)
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(sentence,
                          textStyle: GoogleFonts.boogaloo(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: white))
                    ],
                    totalRepeatCount: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.75,
                    width: MediaQuery.of(context).size.width / 1.15,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 8.0,
                        color: darkAccentColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
//                              fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}
