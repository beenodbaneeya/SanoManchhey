import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  getAlphabets() async {
    return await FirebaseFirestore.instance
        .collection("Alphabets")
        .doc()
        .collection("Letters")
        .get();
  }
}


//ListTile(
//title: Text(e['letter']),
//))
