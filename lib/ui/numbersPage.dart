import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class NumberPage extends StatefulWidget {
  @override
  _NumberPageState createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Numbers');

  @override
  Widget build(BuildContext context) {
    CardController controller;
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
          stream: collectionReference.orderBy('order').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 400,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: TinderSwapCard(
                    totalNum: snapshot.data.docs.length,
                    cardController: controller = CardController(),
                    swipeUpdateCallback:
                        (DragUpdateDetails details, Alignment align) {
                      if (align.x < 0) {
                      } else if (align.x > 0) {}
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {},
                    swipeUp: true,
                    swipeDown: true,
                    orientation: AmassOrientation.TOP,
                    stackNum: 4,
                    swipeEdge: 4.0,
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.width * 0.9,
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    minHeight: MediaQuery.of(context).size.width * 0.8,
                    cardBuilder: (context, index) => Card(
                      child: Container(
                        decoration: myBoxDecoration(context),
                        child: NumberTile(
                          number: snapshot.data.docs[index].get("number"),
                          word: snapshot.data.docs[index].get("word"),
                        ),
                      ),
                      elevation: 20.0,
                    ),
                  ),
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

class NumberTile extends StatelessWidget {
  final String number;
  final String word;

  const NumberTile({
    Key key,
    this.number,
    this.word,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              word,
              style: GoogleFonts.boogaloo(
                  fontSize: 76, color: white, fontWeight: FontWeight.bold),
            ),

//              totalRepeatCount: 2,

            Text(number,
                style: GoogleFonts.boogaloo(
                    fontSize: 150, color: white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
