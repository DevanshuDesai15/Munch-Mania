import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage2.dart';
import 'package:food_recommendation/main.dart';

class dessertUserRecipeGrid extends StatefulWidget {
  @override
  _dessertUserRecipeGridState createState() => _dessertUserRecipeGridState();
}

class _dessertUserRecipeGridState extends State<dessertUserRecipeGrid> {
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .document(userid)
        .collection("HouseRecipes")
        .document("dessert")
        .collection("allDessert")
        .getDocuments();
    return qn.documents;
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
                } else if (snapshot.data.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: <Widget>[
                      Center(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Icon(
                                FontAwesomeIcons.exclamation,
                                color: Colors.blue[100],
                                size: (MediaQuery.of(context).size.width) / 2,
                              ),
                            ),
                            Container(
                              child: Text(
                                'You Dessert Recipe list is empty!\nYou should add one now.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: 2,
                                  color: Colors.blue[100],
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
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
                              return new Container(
                                child: GestureDetector(
                                  onTap: () =>
                                      navigateToDetail(snapshot.data[index]),
                                  child: new GridTile(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.grey,
                                      ),
                                      margin: EdgeInsets.all(10.0),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: <Widget>[
                                          Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            snapshot.data[0]
                                                                    .data[
                                                                "imageURL"])),
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
                                                  top: 50,
                                                  right: 10,
                                                  child: GestureDetector(
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.white60,
                                                            blurRadius: 10.0,
                                                            spreadRadius: 2.0,
                                                            offset: Offset(
                                                              2.0,
                                                              2.0,
                                                            ),
                                                          )
                                                        ],
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Center(
                                                              child:
                                                                  SingleChildScrollView(
                                                                child:
                                                                    AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(32))),
                                                                  content:
                                                                      Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          "The recipe will be permanently deleted!",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 22),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          RawMaterialButton(
                                                                            shape:
                                                                                new CircleBorder(),
                                                                            elevation:
                                                                                4.0,
                                                                            fillColor:
                                                                                Colors.lightBlueAccent,
                                                                            padding:
                                                                                const EdgeInsets.all(15.0),
                                                                            child:
                                                                                new Icon(
                                                                              FontAwesomeIcons.check,
                                                                              color: Colors.white,
                                                                              size: 25.0,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              FirebaseStorage.instance.ref().child("houseRecipes").child(userid).child(snapshot.data[index].data["name"] + ".jpg").delete();
                                                                              Firestore.instance.collection("users").document(userid).collection("HouseRecipes").document("dessert").collection("allDessert").document(snapshot.data[index].data["Name"]).delete();
                                                                              setState(() {
                                                                                getPosts();
                                                                              });
                                                                              Firestore.instance.collection("users").document(userid).collection("PersonalDetails").document("Details").updateData({
                                                                                "recipeUploaded": FieldValue.increment(-1),
                                                                              });
                                                                              Navigator.pop(context);
                                                                              /*Flushbar(
                                                                                backgroundColor: Colors.redAccent,
                                                                                message: 'Removed "${snapshot.data[index].data["name"]}" from your Recipe List',
                                                                                duration: Duration(seconds: 2),
                                                                              )..show(context);*/
                                                                            },
                                                                          ),
                                                                          RawMaterialButton(
                                                                            shape:
                                                                                new CircleBorder(),
                                                                            elevation:
                                                                                4.0,
                                                                            fillColor:
                                                                                Colors.redAccent,
                                                                            padding:
                                                                                const EdgeInsets.all(15.0),
                                                                            child:
                                                                                new Icon(
                                                                              FontAwesomeIcons.times,
                                                                              color: Colors.white,
                                                                              size: 25.0,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
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
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(width: 2.0),
                                                          Text(
                                                            snapshot.data[index]
                                                                    .data[
                                                                "cuisine"],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
