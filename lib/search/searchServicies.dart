import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('products')
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  searchByButtonName(List searchField) {
    print(searchField);
    return Firestore.instance
        .collection('products')
        .where('searchCriteria', arrayContainsAny: searchField)
        .getDocuments();
  }

  searchByButtonType(String searchField) {
    searchField = searchField.toLowerCase();
    if (searchField == "fruit" || searchField == "fruits") {
      searchField = "Fruit";
    } else if (searchField == "vegetable" ||
        searchField == "vegetables" ||
        searchField == "veg") {
      searchField = "Vegetable";
    } else if (searchField == "masala" ||
        searchField == "spices" ||
        searchField == "spice" ||
        searchField == "masalas") {
      searchField = "Masala";
    } else if (searchField == "meat" ||
        searchField == "non-veg" ||
        searchField == "non veg") {
      searchField = "Meat";
    } else if (searchField == "canned" || searchField == "can") {
      searchField = "Canned";
    } else if (searchField == "bakery" ||
        searchField == "baked" ||
        searchField == "bake") {
      searchField = "Bakery";
    } else if (searchField == "dairy" ||
        searchField == "milk products" ||
        searchField == "milk product") {
      searchField = "Dairy";
    }
    print(searchField);
    return Firestore.instance
        .collection('products')
        .where('typeOfProduct', isEqualTo: searchField)
        .getDocuments();
  }
}
