import 'package:cloud_firestore/cloud_firestore.dart';

class DisasterCategory {
  final String? categoryName;

  DisasterCategory({ this.categoryName });

  factory DisasterCategory.fromFirestore(DocumentSnapshot doc) {

    return DisasterCategory(
      categoryName: doc['categoryName'] ?? ''
    );
  }
}