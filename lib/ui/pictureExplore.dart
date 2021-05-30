import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/ui/detailPage.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PictureExplore extends StatefulWidget {
  final String pictureId;
  final String pictureName;

  const PictureExplore({Key key, this.pictureId, this.pictureName})
      : super(key: key);
  @override
  _PictureExploreState createState() => _PictureExploreState();
}

class _PictureExploreState extends State<PictureExplore> {
//  CollectionReference collectionReference =
//      FirebaseFirestore.instance.collection('Pictures').doc(pictureId).collection("PictureType").snapshots();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: myBoxDecoration(context),
//          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Explore',
                  style: GoogleFonts.boogaloo(
                    fontSize: 44.0,
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Pictures')
                        .doc(widget.pictureId)
                        .collection("PictureType")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Swiper(
                          itemCount: snapshot.data.docs.length,
                          itemWidth: MediaQuery.of(context).size.width - 2 * 54,
                          layout: SwiperLayout.STACK,
                          pagination: SwiperPagination(
                              alignment: Alignment.centerRight,
                              builder: DotSwiperPaginationBuilder(
                                  color: white,
                                  activeColor: accentColor,
                                  activeSize: 20,
                                  space: 8)),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetailPage(
                                            name: snapshot.data.docs[index]
                                                .get('name'),
                                            imageUrl: snapshot.data.docs[index]
                                                .get('imgUrl'),
                                            description: snapshot
                                                .data.docs[index]
                                                .get('description'),
                                            category: widget.pictureName,
                                            imgUrl1: snapshot.data.docs[index]
                                                .get('imgUrl1'),
                                          ))),
                              child: PictureTile(
                                name: snapshot.data.docs[index].get('name'),
                                imgUrl: snapshot.data.docs[index].get('imgUrl'),
                                category: widget.pictureName,
                              ),
                            );
                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(accentColor),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PictureTile extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String description;
  final String category;

  const PictureTile(
      {Key key, this.description, this.name, this.imgUrl, this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Column(
              children: [
//            SizedBox(
//              height: 200,
//            ),

                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  color: white,
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: imgUrl,
                          errorWidget: (context, imgUrl, error) =>
                              Text("error"),
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 100,
                            backgroundImage: imageProvider,
                          ),
                        ),
//                            SizedBox(
//                              height: 100,
//                            ),
                        Text(
                          name,
                          style: GoogleFonts.boogaloo(
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                              color: primaryColor),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          category,
                          style: GoogleFonts.boogaloo(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: primaryColor),
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          children: [
                            Text(
                              'Know more',
                              style: GoogleFonts.boogaloo(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                  color: accentColor),
                              textAlign: TextAlign.left,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

//PictureTile(
//name: snapshot.data.docs[index].get('name'),
//imgUrl: snapshot.data.docs[index].get('imgUrl'),
//description: snapshot.data.docs[index].get('description'),
//);
