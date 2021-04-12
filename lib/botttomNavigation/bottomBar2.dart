import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/botttomNavigation/home_screen.dart';
import 'package:food_recommendation/botttomNavigation/inventory.dart';
import 'package:food_recommendation/botttomNavigation/profile2.dart';
import 'package:food_recommendation/botttomNavigation/toDo.dart';

var heightSize;
var color = Colors.amber[100];
var colorIcon = Colors.amber[500];

class bottomBar2 extends StatefulWidget {
  @override
  _bottomBar2State createState() => _bottomBar2State();
}

class _bottomBar2State extends State<bottomBar2> {
  int _selectedIndex = 0;

  List<Widget> bodies = [
    home_screen(),
    inventory(),
    toDo(),
    profile2(),
  ];

  List<IconData> _icons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.solidCheckCircle,
    FontAwesomeIcons.clipboardCheck,
    FontAwesomeIcons.solidUserCircle,
  ];

  @override
  void initState() {
    color = Colors.amber[100];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightSize = MediaQuery.of(context).size.height / 14;
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        height: heightSize,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _icons
              .asMap()
              .entries
              .map(
                (MapEntry map) => _buildIcon(map.key),
              )
              .toList(),
        ),
      ),
      body: SafeArea(child: bodies[_selectedIndex]),
    );
  }

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          if (index == 0) {
            colorIcon = Colors.amber;
          } else if (index == 1) {
            colorIcon = Colors.blueAccent;
          } else if (index == 2) {
            colorIcon = Colors.red;
          } else if (index == 3) {
            colorIcon = Colors.deepOrangeAccent;
          }
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color:
              _selectedIndex == index ? Colors.transparent : Colors.transparent,
        ),
        child: Icon(
          _icons[index],
          size: 25.0,
          color: _selectedIndex == index ? colorIcon : Color(0xFFB4C1C4),
        ),
      ),
    );
  }
}
