import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DaysPage extends StatefulWidget {
  @override
  _DaysPageState createState() => _DaysPageState();
}

class _DaysPageState extends State<DaysPage> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Days');
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
          stream: collectionReference.orderBy('order').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return CarouselSlider.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index, x) {
                    return DayCard(
                      name: snapshot.data.docs[index].get('name'),
                    );
                  },
                  options: CarouselOptions(
                      height: 350,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.easeIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal));
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

class DayCard extends StatelessWidget {
  final String name;

  const DayCard({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Container(
        decoration: BoxDecoration(color: primaryColor),
        child: Center(
          child: Text(
            name,
            style: GoogleFonts.boogaloo(
                fontSize: 70.0,
                fontWeight: FontWeight.bold,
                color: accentColor),
          ),
        ),
      ),
    );
  }
}
