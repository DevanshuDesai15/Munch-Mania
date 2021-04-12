import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/botttomNavigation/home_screen.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage2.dart';
import 'package:food_recommendation/main.dart';
import 'package:food_recommendation/widgetBar/expiryError.dart';

class recommendationThroughExpirey extends StatefulWidget {
  @override
  _recommendationThroughExpireyState createState() =>
      _recommendationThroughExpireyState();
}

class _recommendationThroughExpireyState
    extends State<recommendationThroughExpirey> {
  List<String> myList = List<String>();

  Future getPosts() async {
    var qn = await Firestore.instance
        .collection("users")
        .document(userid)
        .collection("inventory")
        .where("expiringIn", isLessThanOrEqualTo: 5)
        .where("expiringIn", isGreaterThanOrEqualTo: 0)
        .getDocuments();
    if (qn.documents.length > 10) {
      for (int i = 0; i < 10; i++) {
        myList.add(qn.documents[i].data["productName"]);
      }
    } else if (qn.documents.length < 10) {
      for (int i = 0; i < qn.documents.length; i++) {
        myList.add(qn.documents[i].data["productName"]);
      }
    }
    var an = await Firestore.instance
        .collection("recipes")
        .document(dishType)
        .collection(dishAll)
        .where("Ingredients", arrayContainsAny: myList)
        .getDocuments();
    myList.clear();
    return an.documents;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => detailPage2(post: post)));
  }

  var color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(.4),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white70,
          flexibleSpace: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 60.0),
                  child: Text(
                    'Recipes that can be made with your going to expire products.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      ),
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
              future: getPosts(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: Center(
                        child: SpinKitWave(
                            color: Colors.lightBlueAccent,
                            type: SpinKitWaveType.start)),
                  );
                } else if (snapshot.data == null) {
                  return snapShotMissingInRecommender();
                } else if (snapshot.data.length == 0) {
                  return snapShotMissingInRecommender();
                } else {
                  return new Column(
                    children: <Widget>[
                      new Expanded(
                        child: new GridView.builder(
                            itemCount: snapshot.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (_, index) {
                              if (snapshot.data[index].data["dish"] == "veg") {
                                color = Colors.green;
                              } else if (snapshot.data[index].data["dish"] ==
                                  "non-veg") {
                                color = Colors.red;
                              } else {
                                color = Colors.green;
                              }
                              return Tooltip(
                                message: snapshot.data[index].data["name"],
                                child: new Container(
                                  child: GestureDetector(
                                    onTap: () =>
                                        navigateToDetail(snapshot.data[index]),
                                    child: new GridTile(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.black,
                                        ),
                                        margin: EdgeInsets.all(10.0),
                                        width: 210.0,
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: <Widget>[
                                            Container(
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.network(
                                                        snapshot.data[index]
                                                            .data["imageURL"],
                                                        fit: BoxFit.cover,
                                                      ),
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          snapshot.data[index]
                                                              .data["name"],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 1.2,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .caretRight,
                                                              size: 20.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(
                                                                width: 2.0),
                                                            Text(
                                                              snapshot
                                                                  .data[index]
                                                                  .data["name"],
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                  //title: Text(snapshot.data[index].data["productName"]),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
