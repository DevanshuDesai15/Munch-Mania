import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/widgetBar/searchBeverage.dart';
import 'package:food_recommendation/widgetBar/searchDessert.dart';
import 'package:food_recommendation/widgetBar/searchDish.dart';

class searchAppBar extends StatefulWidget {
  @override
  _searchAppBarState createState() => _searchAppBarState();
}

int _selectedIndex = 0;

class _searchAppBarState extends State<searchAppBar> {
  List<IconData> _icons = [
    FontAwesomeIcons.utensils,
    FontAwesomeIcons.glassMartini,
    FontAwesomeIcons.iceCream,
  ];
  List<String> textButton = ["FOOD", "BEVERAGE", "DESSERTS"];
  List<Widget> bo = [
    searchDish(),
    searchBeverage(),
    searchDessert(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.white70,
          flexibleSpace: SafeArea(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _icons
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
      body: SafeArea(child: bo[_selectedIndex]),
    );
  }

  var color = Colors.green[100];
  var colorIcon = Colors.green;
  var colorText = Colors.green;
  Widget _buildIcon(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
            color = Colors.green[100];
            colorIcon = Colors.green;
            colorText = Colors.green;
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
                Icon(
                  _icons[index],
                  size: 20.0,
                  color:
                      _selectedIndex == index ? colorIcon : Color(0xFFB4C1C4),
                ),
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
