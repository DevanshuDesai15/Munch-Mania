import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/inventoryPack/addininventory.dart';
import 'package:food_recommendation/inventoryPack/inventoryList2.dart';
import 'package:food_recommendation/inventoryPack/recipeAdder.dart';
import 'package:food_recommendation/inventoryPack/selectedDishes.dart';
import 'package:food_recommendation/inventoryPack/userRecipeGrid.dart';
import 'package:food_recommendation/widgetBar/selectedDishesWidget.dart';

class inventory extends StatefulWidget {
  final String title;
  inventory({this.title});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

int _selectedIndex = 0;
var wantToAdd = true;

class _MyHomePageState extends State<inventory> {
  List<String> textButton = [
    "Items Present",
    "House Recipes",
    "Add Recipe",
  ];

  List<Widget> bodies = [
    inventoryList2(),
    userRecipeGrid(),
    recipeAdder(),
    addininventory(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.local_grocery_store,
              color: Colors.lightBlueAccent,
            ),
            backgroundColor: Colors.white,
            label: 'Selected Recipes',
            labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => selectedDishes()),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          wantToAdd == false ? "Add to Inventory" : "Inventory",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              icon: Icon(
                wantToAdd
                    ? CupertinoIcons.add_circled
                    : CupertinoIcons.clear_circled,
                color: (_selectedIndex == 1 || _selectedIndex == 2)
                    ? Colors.transparent
                    : (wantToAdd ? Colors.blueAccent : Colors.redAccent),
                size: MediaQuery.of(context).size.width / 12.5,
              ),
              onPressed: () {
                if (_selectedIndex == 1 || _selectedIndex == 2) {
                } else {
                  setState(() {
                    if (wantToAdd == false) {
                      _selectedIndex = 0;
                    } else {
                      _selectedIndex = 3;
                    }
                    wantToAdd = !wantToAdd;
                  });
                }
              }),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.white70,
            flexibleSpace: SafeArea(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      body: SafeArea(child: bodies[_selectedIndex]),
    );
  }

  var color = Colors.blue[100];
  var colorText = Colors.blueAccent;
  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          color = Colors.blue[100];
          colorText = Colors.blueAccent;
          wantToAdd = true;
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
    );
  }
}
