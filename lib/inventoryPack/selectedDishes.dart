import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage.dart';
import 'package:food_recommendation/main.dart';
import 'package:food_recommendation/widgetBar/selectedDishesWidget.dart';

class selectedDishes extends StatefulWidget {
  @override
  _selectedDishesState createState() => _selectedDishesState();
}

class _selectedDishesState extends State<selectedDishes> {
  Future getSelectedDishes() async {
    //List<String> names = ["Potatoes","Eggs","Chicken","Garlic","Onion","Lemon","Soda","paprika","yoghurt","ginger"];
    //QuerySnapshot qn=await Firestore.instance.collection("recipes").document("food")
    //  .collection("allFood").where("Ingredients",arrayContainsAny: names).getDocuments();
    QuerySnapshot qn = await Firestore.instance
        .collection("users")
        .document(userid)
        .collection("cart")
        .orderBy("timestampOfDateAdded", descending: true)
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => detailPage(post: post)));
  }

  var color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          flexibleSpace: SafeArea(
            child: Column(
              //padding: EdgeInsets.symmetric(vertical: 50.0),
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 60.0),
                  child: Text(
                    'Here is the list of your chosen recipes.',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: selectedDishesWidget(),
    );
  }
}
