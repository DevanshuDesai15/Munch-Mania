import 'package:flutter/material.dart';
import 'package:food_recommendation/todoPack/todoAppToUser.dart';
import 'package:food_recommendation/todoPack/todoFinalList.dart';
import 'package:food_recommendation/todoPack/todoUser.dart';

class todoAppBar extends StatefulWidget {
  @override
  _todoAppBarState createState() => _todoAppBarState();
}

int _selectedIndex = 0;

class _todoAppBarState extends State<todoAppBar> {
  List<String> textButton = [
    "List By You",
    "List By Us",
    "Final List",
  ];
  List<Widget> bo = [
    todoUser(),
    todoAppToUser(),
    todoFinalList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
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
      body: SafeArea(child: bo[_selectedIndex]),
    );
  }

  var color = Colors.red[100];
  var colorText = Colors.red;
  Widget _buildIcon(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
            color = Colors.red[100];
            colorText = Colors.red;
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
