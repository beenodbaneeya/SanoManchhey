import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xffffbf08),
        child: Column(
          children: [
            Container(
//              color: Color(0xffffbf08),
//              height: 100,
                ),
            Image.asset('assets/images/minion2.png')
          ],
        ),
      ),
    );
  }
}
