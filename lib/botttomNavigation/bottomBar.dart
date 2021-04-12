import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recommendation/botttomNavigation/home_screen.dart';
import 'package:food_recommendation/botttomNavigation/inventory.dart';
import 'package:food_recommendation/botttomNavigation/profile2.dart';
import 'package:food_recommendation/botttomNavigation/toDo.dart';

class bottomBar extends StatefulWidget {
  bottomBar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<bottomBar> {
  int currentTabIndex = 0;

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  List<Widget> tabs = [
    home_screen(),
    inventory(),
    toDo(),
    profile2(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(backgroundColor: Colors.white, items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.check_mark_circled),
              title: Text("Inventory")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              title: Text("To-Shop List")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), title: Text("User Info"))
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return home_screen();
              break;
            case 1:
              return inventory();
              break;
            case 2:
              return toDo();
              break;
            case 3:
              return profile2();
              break;
            default:
              return home_screen();
              break;
          }
        });
  }
}
