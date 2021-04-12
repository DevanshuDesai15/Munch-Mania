import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recommendation/inventoryPack/dessertUserRecipeGrid.dart';
import 'package:food_recommendation/inventoryPack/drinkUserRecipeGrid.dart';
import 'package:food_recommendation/inventoryPack/foodUserRecipeGrid.dart';

class userRecipeGrid extends StatefulWidget {
  @override
  _userRecipeGridState createState() => _userRecipeGridState();
}

class _userRecipeGridState extends State<userRecipeGrid> {
  int _selectedIndex = 0;

  List<String> textButton = ["Food", "Beverage", "Dessert"];

  List<Widget> bodies = [
    foodUserRecipeGrid(),
    drinkUserRecipeGrid(),
    dessertUserRecipeGrid(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2.0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white70,
            flexibleSpace: SafeArea(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: textButton
                        .asMap()
                        .entries
                        .map(
                          (MapEntry map) => _buildIcon(map.key),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: bodies[_selectedIndex],
    );
  }

  var color = Colors.blue[100];
  var colorText = Colors.blueAccent;
  Widget _buildIcon(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
            color = Colors.blue[100];
            colorText = Colors.blueAccent;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: _selectedIndex == index ? color : Color(0xFFE7EBEE),
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Text(
                  textButton[index],
                  style: TextStyle(
                    color:
                        _selectedIndex == index ? colorText : Color(0xFFB4C1C4),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
