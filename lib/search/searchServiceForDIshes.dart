import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchServiceForDishes {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('recipes')
        .doc("food")
        .collection("allFood")
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
