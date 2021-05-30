import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';

class MonthsPage extends StatefulWidget {
  @override
  _MonthsPageState createState() => _MonthsPageState();
}

class _MonthsPageState extends State<MonthsPage> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Months');
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
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
              return GridView.builder(
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3),
                itemBuilder: (context, index) {
                  return MonthTile(
                    name: snapshot.data.docs[index].get('name'),
                  );
                },
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

class MonthTile extends StatelessWidget {
  final String name;

  const MonthTile({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10.0,
        child: Container(
          decoration: myBoxDecoration(context),
          child: Center(
            child: Text(
              name,
              style: GoogleFonts.boogaloo(
                  fontWeight: FontWeight.bold, fontSize: 36.0, color: white),
            ),
          ),
        ),
      ),
    );
  }
}
