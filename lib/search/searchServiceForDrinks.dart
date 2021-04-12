import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchServiceForBeverages {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('recipes')
        .document("drinks")
        .collection("allBeverages")
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
