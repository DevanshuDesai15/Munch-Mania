import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchServiceForBeverages {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('recipes')
        .doc("drinks")
        .collection("allBeverages")
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
