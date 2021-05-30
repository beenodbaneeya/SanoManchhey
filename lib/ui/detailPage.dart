import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sano_manchey/services/colors.dart';
import 'package:sano_manchey/widgets/appBar.dart';
import 'package:sano_manchey/widgets/boxDecoration.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final String imgUrl1;

  const DetailPage({
    Key key,
    this.name,
    this.category,
    this.description,
    this.imageUrl,
    this.imgUrl1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: primaryColor,
      ),
      body: Container(
        decoration: myBoxDecoration(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 92, right: 12, top: 32),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  errorWidget: (context, imgUrl, error) => Text("error"),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 110,
                    backgroundImage: imageProvider,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//                    SizedBox(height: 300),
                    Text(
                      name,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.boogaloo(
                          fontSize: 56,
                          color: white,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      category,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.boogaloo(
                          fontSize: 31,
                          color: white,
                          fontWeight: FontWeight.w300),
                    ),
                    Divider(
                      color: Colors.black38,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      description,
                      maxLines: 20,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.boogaloo(
                          fontSize: 20,
                          color: white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Divider(
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  'Gallery',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.boogaloo(
                      fontWeight: FontWeight.w300, fontSize: 25, color: white),
                ),
              ),
              Container(
                  height: 170,
                  padding: const EdgeInsets.only(left: 32),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Card(
                        child: AspectRatio(
                            aspectRatio: 1,
                            child: CachedNetworkImage(
                              imageUrl: imgUrl1,
                              fit: BoxFit.cover,
                            )),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        clipBehavior: Clip.antiAlias,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
