import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/main.dart';

class todoUser extends StatefulWidget {
  @override
  _todoUserState createState() => _todoUserState();
}

class _todoUserState extends State<todoUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController quantityController = new TextEditingController();

  var colorBgOfCheckbox;
  var colorIconCheckbox;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("users")
            .document(userid)
            .collection("toDoList")
            .document("sections")
            .collection("userTodo")
            .orderBy("check", descending: false)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                child: Center(
                    child: SpinKitWave(
                        color: Colors.redAccent, type: SpinKitWaveType.start)),
              ),
            );
          } else if (snapshot.data.documents.length == 0) {
            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Icon(
                              FontAwesomeIcons.exclamation,
                              color: Colors.redAccent,
                              size: (MediaQuery.of(context).size.width) / 2,
                            ),
                          ),
                          Container(
                            child: Text(
                              'You product list is empty!\nYou should add one now.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 2,
                                color: Colors.redAccent,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            );
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (_, index) {
                  if (snapshot.data.documents[index].data["check"] == true) {
                    colorBgOfCheckbox = Colors.red[100];
                    colorIconCheckbox = Colors.red;
                  } else {
                    colorBgOfCheckbox = Color(0xFFE7EBEE);
                    colorIconCheckbox = Color(0xFFB4C1C4);
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height:
                              (MediaQuery.of(context).size.height / 10) + 10,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.redAccent, width: .5),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffA22447).withOpacity(.1),
                                  offset: Offset(20, 20),
                                  blurRadius: 20,
                                  spreadRadius: .1)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                50,
                                        child: Text(
                                          "Product Name",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        )),
                                    Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                50,
                                        child: Text(
                                          snapshot.data.documents[index]
                                                  .data["productName"][0]
                                                  .toUpperCase() +
                                              snapshot.data.documents[index]
                                                  .data["productName"]
                                                  .substring(1),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                              ),
                              new Spacer(),
                              Container(
                                width:
                                    80, //height: MediaQuery.of(context).size.height/12,
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        width: .5, color: Colors.transparent),
                                    right: BorderSide(
                                        width: .5, color: Colors.transparent),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: .5,
                                      width: 50,
                                      child: const DecoratedBox(
                                        decoration: const BoxDecoration(
                                            color: Colors.black45),
                                      ),
                                    ),
                                    Text(
                                      snapshot.data.documents[index]
                                          .data["quantity"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot
                                          .data.documents[index].data["unit"],
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.height / 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.yellow,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Center(
                                            child: SingleChildScrollView(
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
                                                      SizedBox(height: 10),
                                                      Center(
                                                        child: Text(
                                                          "Edit the Quantity",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Center(
                                                        child: Text(
                                                          'Present Quantity: ${snapshot.data.documents[index].data["quantity"].toString()} grams',
                                                          style: TextStyle(
                                                              fontSize: 15,
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
                                                            EdgeInsets.all(8.0),
                                                        child: TextFormField(
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
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                        20.0,
                                                                        10.0,
                                                                        20.0,
                                                                        10.0),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            32.0)),
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
                                                        children: <Widget>[
                                                          RawMaterialButton(
                                                            shape:
                                                                new CircleBorder(),
                                                            elevation: 4.0,
                                                            fillColor: Colors
                                                                .lightBlueAccent,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: new Icon(
                                                              FontAwesomeIcons
                                                                  .check,
                                                              color:
                                                                  Colors.white,
                                                              size: 25.0,
                                                            ),
                                                            onPressed: () {
                                                              Firestore.instance
                                                                  .collection(
                                                                      'users')
                                                                  .document(
                                                                      userid)
                                                                  .collection(
                                                                      'toDoList')
                                                                  .document(
                                                                      "sections")
                                                                  .collection(
                                                                      "userTodo")
                                                                  .document(snapshot
                                                                          .data
                                                                          .documents[
                                                                              index]
                                                                          .data["productName"]
                                                                              [
                                                                              0]
                                                                          .toUpperCase() +
                                                                      snapshot
                                                                          .data
                                                                          .documents[
                                                                              index]
                                                                          .data[
                                                                              "productName"]
                                                                          .substring(
                                                                              1))
                                                                  .updateData({
                                                                'quantity': int.parse(
                                                                    quantityController
                                                                        .text),
                                                              });
                                                              quantityController
                                                                  .clear();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          RawMaterialButton(
                                                            shape:
                                                                new CircleBorder(),
                                                            elevation: 4.0,
                                                            fillColor: Colors
                                                                .redAccent,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: new Icon(
                                                              FontAwesomeIcons
                                                                  .times,
                                                              color:
                                                                  Colors.white,
                                                              size: 25.0,
                                                            ),
                                                            onPressed: () {
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
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.height / 20,
                                    decoration: BoxDecoration(
                                        color: colorBgOfCheckbox,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Center(
                                      child: Icon(
                                        Icons.check,
                                        color: colorIconCheckbox,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (snapshot.data.documents[index]
                                            .data["quantity"] <=
                                        0) {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'Quantity cannot be zero or less than zero'),
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.redAccent,
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      if (snapshot.data.documents[index]
                                              .data["check"] ==
                                          true) {
                                        Firestore.instance
                                            .collection("users")
                                            .document(userid)
                                            .collection("toDoList")
                                            .document("sections")
                                            .collection("userTodo")
                                            .document((snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["productName"])[0]
                                                    .toUpperCase() +
                                                snapshot.data.documents[index]
                                                    .data["productName"]
                                                    .substring(1))
                                            .updateData({
                                          "check": false,
                                        });
                                      } else {
                                        Firestore.instance
                                            .collection("users")
                                            .document(userid)
                                            .collection("toDoList")
                                            .document("sections")
                                            .collection("userTodo")
                                            .document((snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["productName"])[0]
                                                    .toUpperCase() +
                                                snapshot.data.documents[index]
                                                    .data["productName"]
                                                    .substring(1))
                                            .updateData({
                                          "check": true,
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: SingleChildScrollView(
                                                  child: AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    32.0))),
                                                    content: Column(
                                                      children: <Widget>[
                                                        SizedBox(height: 10),
                                                        Center(
                                                          child: Text(
                                                            "Do you to add it to the final list and remove the item from this list?",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            RawMaterialButton(
                                                              shape:
                                                                  new CircleBorder(),
                                                              elevation: 4.0,
                                                              fillColor: Colors
                                                                  .lightBlueAccent,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      15.0),
                                                              child: new Icon(
                                                                FontAwesomeIcons
                                                                    .check,
                                                                color: Colors
                                                                    .white,
                                                                size: 25.0,
                                                              ),
                                                              onPressed: () {
                                                                Firestore
                                                                    .instance
                                                                    .collection(
                                                                        "users")
                                                                    .document(
                                                                        userid)
                                                                    .collection(
                                                                        "toDoList")
                                                                    .document(
                                                                        "sections")
                                                                    .collection(
                                                                        "finalTodo")
                                                                    .document((snapshot.data.documents[index].data["productName"])[0]
                                                                            .toUpperCase() +
                                                                        snapshot
                                                                            .data
                                                                            .documents[index]
                                                                            .data["productName"]
                                                                            .substring(1))
                                                                    .setData({
                                                                  "unit": snapshot
                                                                      .data
                                                                      .documents[
                                                                          index]
                                                                      .data["unit"],
                                                                  "check":
                                                                      false,
                                                                  "quantity": snapshot
                                                                      .data
                                                                      .documents[
                                                                          index]
                                                                      .data["quantity"],
                                                                  "productName": snapshot
                                                                      .data
                                                                      .documents[
                                                                          index]
                                                                      .data["productName"],
                                                                });
                                                                Firestore
                                                                    .instance
                                                                    .collection(
                                                                        "users")
                                                                    .document(
                                                                        userid)
                                                                    .collection(
                                                                        "toDoList")
                                                                    .document(
                                                                        "sections")
                                                                    .collection(
                                                                        "userTodo")
                                                                    .document((snapshot.data.documents[index].data["productName"])[0]
                                                                            .toUpperCase() +
                                                                        snapshot
                                                                            .data
                                                                            .documents[index]
                                                                            .data["productName"]
                                                                            .substring(1))
                                                                    .delete();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            RawMaterialButton(
                                                              shape:
                                                                  new CircleBorder(),
                                                              elevation: 4.0,
                                                              fillColor: Colors
                                                                  .redAccent,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      15.0),
                                                              child: new Icon(
                                                                FontAwesomeIcons
                                                                    .times,
                                                                color: Colors
                                                                    .white,
                                                                size: 25.0,
                                                              ),
                                                              onPressed: () {
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
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffA22447).withOpacity(.1),
                                      offset: Offset(20, 20),
                                      blurRadius: 20,
                                      spreadRadius: .1)
                                ],
                                color: Colors.redAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                                child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: SingleChildScrollView(
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32))),
                                        content: Column(
                                          children: <Widget>[
                                            Center(
                                              child: Text(
                                                "Want to remove ${snapshot.data.documents[index].data["productName"]} from your list",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                RawMaterialButton(
                                                  shape: new CircleBorder(),
                                                  elevation: 4.0,
                                                  fillColor:
                                                      Colors.lightBlueAccent,
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: new Icon(
                                                    FontAwesomeIcons.check,
                                                    color: Colors.white,
                                                    size: 25.0,
                                                  ),
                                                  onPressed: () {
                                                    Firestore.instance
                                                        .collection("users")
                                                        .document(userid)
                                                        .collection("toDoList")
                                                        .document("sections")
                                                        .collection("userTodo")
                                                        .document(snapshot
                                                                .data
                                                                .documents[
                                                                    index]
                                                                .data[
                                                                    "productName"]
                                                                    [0]
                                                                .toUpperCase() +
                                                            snapshot
                                                                .data
                                                                .documents[
                                                                    index]
                                                                .data[
                                                                    "productName"]
                                                                .substring(1))
                                                        .delete();
                                                    Navigator.pop(context);
                                                    /*Flushbar(
                                                      backgroundColor: Colors.redAccent,
                                                      message: 'Removed "${snapshot.data[index].data["productName"]}" from your Recipe List',
                                                      duration: Duration(seconds: 1),
                                                    )..show(context);*/
                                                  },
                                                ),
                                                RawMaterialButton(
                                                  shape: new CircleBorder(),
                                                  elevation: 4.0,
                                                  fillColor: Colors.redAccent,
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: new Icon(
                                                    FontAwesomeIcons.times,
                                                    color: Colors.white,
                                                    size: 25.0,
                                                  ),
                                                  onPressed: () {
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
                        )
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
