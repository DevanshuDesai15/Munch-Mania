import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_recommendation/main.dart';

class inventoryList2 extends StatefulWidget {
  @override
  _inventoryList2State createState() => _inventoryList2State();
}

var colorsCard;

class _inventoryList2State extends State<inventoryList2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController quantityController = new TextEditingController();

  Future getInventoryList() async {
    QuerySnapshot qn = await Firestore.instance
        .collection("users")
        .document(userid)
        .collection("inventory")
        .orderBy('expiringIn', descending: false)
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("users")
                .document(userid)
                .collection("inventory")
                .orderBy('expiringIn', descending: false)
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    child: Center(
                        child: SpinKitWave(
                            color: Colors.lightBlueAccent,
                            type: SpinKitWaveType.start)),
                  ),
                );
              } else if (snapshot.data.documents.length == 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: .5,
                      width: MediaQuery.of(context).size.width - 50,
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.black45),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Icon(
                              FontAwesomeIcons.exclamation,
                              color: Colors.blue[100],
                              size: (MediaQuery.of(context).size.width) / 2,
                            ),
                          ),
                          Container(
                            child: Text(
                              'You product list is empty!\nYou should add one now.',
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
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (_, index) {
                    print("a");
                    if (snapshot.data.documents[index].data["expiringIn"] ==
                            0 ||
                        snapshot.data.documents[index].data["expiringIn"] < 0) {
                      colorsCard = Colors.red;
                    } else if ((snapshot
                                .data.documents[index].data["expiringIn"] >
                            0) &&
                        (snapshot.data.documents[index].data["expiringIn"] <=
                            3)) {
                      colorsCard = Colors.red[200];
                    } else if ((snapshot
                                .data.documents[index].data["expiringIn"] >
                            0) &&
                        (snapshot.data.documents[index].data["expiringIn"] <=
                            5)) {
                      colorsCard = Colors.red[100];
                    } else {
                      colorsCard = Colors.white;
                    }

                    return Tooltip(
                      message:
                          "${snapshot.data.documents[index].data["productName"]}",
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 5, bottom: 10),
                          child: Container(
                            height: 130,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: colorsCard,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start, //change here don't //worked
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 125,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.orangeAccent,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5)),
                                                image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data
                                                      .documents[index]
                                                      .data["imageURL"]),
                                                  fit: BoxFit.cover,
                                                  alignment:
                                                      Alignment.topCenter,
                                                ),
                                              ),
                                              child: Container(
                                                height: 125,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      Colors.white
                                                          .withOpacity(0.0),
                                                      colorsCard,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5)),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 8, 0, 3),
                                                    child: Text(
                                                      "${snapshot.data.documents[index].data["productName"][0].toUpperCase()}${snapshot.data.documents[index].data["productName"].substring(1)}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 2),
                                                    child: Text(
                                                      'Type: ${snapshot.data.documents[index].data["typeOfProduct"]}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 5),
                                                    child: Text(
                                                      'Expiring in ${snapshot.data.documents[index].data["expiringIn"]} days',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        //SizedBox(width:60),
                                        new Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: colorsCard,
                                                  border: Border.all(
                                                      color: Colors.black12),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Quantity',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: .5,
                                                        width: 50,
                                                        child:
                                                            const DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors
                                                                      .black45),
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data
                                                            .documents[index]
                                                            .data["quantity"]
                                                            .toStringAsFixed(2),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data
                                                            .documents[index]
                                                            .data["unit"],
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: new Offset(0.0, 2.0),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Center(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        32.0))),
                                                        content: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            children: <Widget>[
                                                              SizedBox(
                                                                  height: 10),
                                                              Center(
                                                                child: Text(
                                                                  "Edit the Quantity",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Center(
                                                                child: Text(
                                                                  'Present Quantity: ${snapshot.data.documents[index].data["quantity"].toString()} ${snapshot.data.documents[index].data["unit"]}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .numberWithOptions(),
                                                                  controller:
                                                                      quantityController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'Enter new quantity',
                                                                    contentPadding:
                                                                        EdgeInsets.fromLTRB(
                                                                            20.0,
                                                                            10.0,
                                                                            20.0,
                                                                            10.0),
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(32.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  RawMaterialButton(
                                                                    shape:
                                                                        new CircleBorder(),
                                                                    elevation:
                                                                        4.0,
                                                                    fillColor:
                                                                        Colors
                                                                            .lightBlueAccent,
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        15.0),
                                                                    child:
                                                                        new Icon(
                                                                      FontAwesomeIcons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          25.0,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Firestore
                                                                          .instance
                                                                          .collection(
                                                                              'users')
                                                                          .document(
                                                                              userid)
                                                                          .collection(
                                                                              'inventory')
                                                                          .document(snapshot.data.documents[index].data["productName"][0].toUpperCase() +
                                                                              snapshot.data.documents[index].data["productName"].substring(
                                                                                  1))
                                                                          .updateData({
                                                                        'quantity':
                                                                            int.parse(quantityController.text),
                                                                      }).catchError((err) =>
                                                                              print("kush" + err));
                                                                      quantityController
                                                                          .clear();
                                                                      Navigator.pop(
                                                                          context);
                                                                      /*Flushbar(
                                                                        backgroundColor: Colors.blueAccent,
                                                                        message: 'Quantity edited successfully!',
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
                                                                        Colors
                                                                            .redAccent,
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        15.0),
                                                                    child:
                                                                        new Icon(
                                                                      FontAwesomeIcons
                                                                          .times,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          25.0,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Center(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            32))),
                                                        content: Column(
                                                          children: <Widget>[
                                                            Center(
                                                              child: Text(
                                                                "Sure about that?",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        22),
                                                              ),
                                                            ),
                                                            SizedBox(height: 5),
                                                            Center(
                                                              child: Text(
                                                                'You still have ${snapshot.data.documents[index].data["quantity"].toString()} ${snapshot.data.documents[index].data["unit"]}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                            SizedBox(height: 5),
                                                            Center(
                                                              child: Text(
                                                                '(approx)',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                RawMaterialButton(
                                                                  shape:
                                                                      new CircleBorder(),
                                                                  elevation:
                                                                      4.0,
                                                                  fillColor: Colors
                                                                      .lightBlueAccent,
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                  child:
                                                                      new Icon(
                                                                    FontAwesomeIcons
                                                                        .check,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 25.0,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Firestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .document(
                                                                            userid)
                                                                        .collection(
                                                                            'inventory')
                                                                        .document(snapshot.data.documents[index].data["productName"][0].toUpperCase() +
                                                                            snapshot.data.documents[index].data["productName"].substring(1))
                                                                        .delete();
                                                                    Firestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .document(
                                                                            userid)
                                                                        .collection(
                                                                            'PersonalDetails')
                                                                        .document(
                                                                            'Details')
                                                                        .updateData({
                                                                      "countOfItems":
                                                                          FieldValue.increment(
                                                                              -1)
                                                                    });
                                                                    setState(
                                                                        () {
                                                                      getInventoryList();
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                    /*Flushbar(
                                                                      backgroundColor: Colors.redAccent,
                                                                      message: "${snapshot.data[index].data["productName"][0].toUpperCase()+snapshot.data[index].data["productName"].substring(1)} is removed from your inventory!",
                                                                      duration: Duration(seconds: 2),
                                                                    )..show(context);*/
                                                                  },
                                                                ),
                                                                RawMaterialButton(
                                                                  shape:
                                                                      new CircleBorder(),
                                                                  elevation:
                                                                      4.0,
                                                                  fillColor: Colors
                                                                      .redAccent,
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                  child:
                                                                      new Icon(
                                                                    FontAwesomeIcons
                                                                        .times,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 25.0,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
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
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
