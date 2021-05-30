import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/ui/pictureExplore.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';

class PicturesPage extends StatefulWidget {
  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Pictures');
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8,
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 2 : 3),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PictureExplore(
                                      pictureId: snapshot.data.docs[index]
                                          .get('pictureId'),
                                      pictureName:
                                          snapshot.data.docs[index].get('name'),
                                    ))),
                        child: PictureTile(
                          name: snapshot.data.docs[index].get('name'),
                          imageUrl: snapshot.data.docs[index].get('imageUrl'),
                          pictureId: snapshot.data.docs[index].get('pictureId'),
                        ),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                ),
              );
            },
          )),
    );
  }
}

class PictureTile extends StatelessWidget {
  final String pictureId;
  final String name;
  final String imageUrl;

  const PictureTile({Key key, this.pictureId, this.name, this.imageUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.black26,
            ),
            alignment: Alignment.center,
          ),
        ),
        Center(
          child: Text(
            name,
            style: GoogleFonts.boogaloo(
              fontWeight: FontWeight.w900,
              color: white,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
