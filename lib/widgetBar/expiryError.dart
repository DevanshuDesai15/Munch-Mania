import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String testDevice = "Mobile Id";

class snapShotMissingInRecommender extends StatefulWidget {
  @override
  _snapShotMissingInRecommenderState createState() =>
      _snapShotMissingInRecommenderState();
}

class _snapShotMissingInRecommenderState
    extends State<snapShotMissingInRecommender> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    FontAwesomeIcons.exclamation,
                    color: Colors.redAccent,
                    size: (MediaQuery.of(context).size.width) / 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.25,
                    child: Text(
                      'Hurray!!\nNone of your items are going to expire soon.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        color: Colors.redAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
