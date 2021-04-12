import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/search/searchAppBar.dart';
import 'package:food_recommendation/widgetBar/searchDish.dart';
import 'package:food_recommendation/widgetBar/selectedDishesWidget.dart';
import 'package:food_recommendation/widgetBar/trendingBeverages.dart';
import 'package:food_recommendation/widgetBar/trendingDesserts.dart';
import 'package:food_recommendation/widgetBar/trendingDishes.dart';

String dishType;
String dishAll;

class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  int _selectedIndex = 0;
  List<String> headingName = [
    "What would you like to eat today?",
    "What would you like to drink today?",
    "Looks like you have a sweet tooth!",
    "Here are your selected recipes to try!",
    "Search for a Recipe in our database!",
  ];
  List<Widget> bodies = [
    trendingDishes(),
    trendingBeverages(),
    trendingDeserts(),
    selectedDishesWidget(),
    searchAppBar(),
  ];

  List<IconData> _icons = [
    FontAwesomeIcons.utensils,
    FontAwesomeIcons.glassMartini,
    FontAwesomeIcons.iceCream,
    FontAwesomeIcons.book,
    FontAwesomeIcons.search,
  ];

  String head;

  @override
  void initState() {
    dishAll = "allFood";
    dishType = "food";
    head = headingName[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.width / 2.15),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.white70,
          flexibleSpace: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.width / 18),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 19.6,
                      right: MediaQuery.of(context).size.width / 8.72),
                  child: Text(
                    head,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 15.65,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width / 19.6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _icons
                      .asMap()
                      .entries
                      .map(
                        (MapEntry map) => _buildIcon(map.key),
                      )
                      .toList(),
                ),
                /*Center(
                child: new Container(
                  height: 0.5,
                  width:300,
                  color:Color(0xFFB4C1C4 ),
                ),
              ),*/
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(child: bodies[_selectedIndex]),
    );
  }

  var color = Colors.red[100];
  var colorIcon = Colors.red[500];

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          head = headingName[index];
          if (index == 0) {
            color = Colors.red[100];
            colorIcon = Colors.redAccent;
            dishAll = "allFood";
            dishType = "food";
          } else if (index == 1) {
            color = Colors.blue[100];
            colorIcon = Colors.blueAccent;
            dishAll = "allBeverages";
            dishType = "drinks";
          } else if (index == 2) {
            color = Colors.pink[100];
            colorIcon = Colors.pinkAccent;
            dishAll = "allDessert";
            dishType = "dessert";
          } else if (index == 3) {
            color = Colors.amber[100];
            colorIcon = Colors.amberAccent;
          } else if (index == 4) {
            color = Colors.green[100];
            colorIcon = Colors.green;
          }
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 6.545,
        width: MediaQuery.of(context).size.width / 6.545,
        decoration: BoxDecoration(
          color: _selectedIndex == index ? color : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          _icons[index],
          size: MediaQuery.of(context).size.width / 15.65,
          color: _selectedIndex == index ? colorIcon : Color(0xFFB4C1C4),
        ),
      ),
    );
  }
}
