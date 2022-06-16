import 'dart:io';
import 'package:bpbd_jatim/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //initialize firestore
  var db = FirebaseFirestore.instance;
  final username = '';

  Stream<List<DisasterCategory>> streamDisasterCategories () {
    var ref = db.collection('disasterCategories');

    return ref.snapshots().map((list) => 
      list.docs.map((doc) => DisasterCategory.fromFirestore(doc)).toList());
  }

}