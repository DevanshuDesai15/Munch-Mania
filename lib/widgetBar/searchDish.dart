import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage2.dart';
import 'package:food_recommendation/search/searchServiceForDIshes.dart';

class searchDish extends StatefulWidget {
  @override
  _searchDishState createState() => _searchDishState();
}

class _searchDishState extends State<searchDish> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.length == 0 && value.length == 1) {
      SearchServiceForDishes().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (val) {
            initiateSearch(val);
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 25.0),
              hintText: 'Search For Food Recipe',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      GridView.count(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          crossAxisSpacing: 4.0,
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          primary: false,
          shrinkWrap: true,
          children: tempSearchStore.map((element) {
            return buildResultCard(element, context);
          }).toList())
    ]));
  }
}

Future abcd(String dishName) async {
  QuerySnapshot ab = await Firestore.instance
      .collection("recipes")
      .document("food")
      .collection("allFood")
      .getDocuments();
  //print("Result : "+ab.data.toString());
  return ab.documents;
}

var color;
Widget buildResultCard(data, BuildContext context) {
  if (data["dish"] == "veg") {
    color = Colors.green;
  } else if (data["dish"] == "non-veg") {
    color = Colors.red;
  } else {
    color = Colors.green;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => detailPage2(post: post)));
  }

  return new Container(
    child: GestureDetector(
      onTap: () => {
        Firestore.instance
            .collection('recipes')
            .document("food")
            .collection("allFood")
            .where("name", isEqualTo: data["name"])
            .getDocuments()
            .then((QuerySnapshot docs) {
          navigateToDetail(docs.documents[0]);
        })
      }, //navigateToDetail(abcd(data["name"])),
      child: new GridTile(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.amber,
          ),
          margin: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width / 2.5,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(data["imageURL"])),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                              offset: Offset(
                                2.0,
                                2.0,
                              ),
                            )
                          ],
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data["name"],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.caretRight,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2.0),
                              Text(
                                data["cuisine"],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
