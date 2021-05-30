import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';

class ColorPage extends StatefulWidget {
  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Colors');
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
          stream: collectionReference.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
//                    scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.4,
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 2 : 3),
                  itemBuilder: (context, index) {
                    return ColorTile(
                      name: snapshot.data.docs[index].get('name'),
                      imageUrl: snapshot.data.docs[index].get('imageUrl'),
                      imgUrl: snapshot.data.docs[index].get('imgUrl'),
                    );
                  });
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

class ColorTile extends StatefulWidget {
  final String imageUrl;
  final String imgUrl;
  final String name;

  const ColorTile({Key key, this.imageUrl, this.name, this.imgUrl})
      : super(key: key);
  @override
  _ColorTileState createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(widget.name,
              style: GoogleFonts.boogaloo(
                  fontWeight: FontWeight.bold, fontSize: 56, color: white)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 150,
              width: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
//                              fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 150,
              width: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: widget.imgUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
//                              fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
