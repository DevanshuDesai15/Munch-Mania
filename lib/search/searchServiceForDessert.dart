import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchServiceForDessert {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('recipes')
        .doc("dessert")
        .collection("allDessert")
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
