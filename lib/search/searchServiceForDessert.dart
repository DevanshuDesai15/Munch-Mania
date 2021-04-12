import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchServiceForDessert {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('recipes')
        .document("dessert")
        .collection("allDessert")
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
