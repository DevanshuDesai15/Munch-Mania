import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/botttomNavigation/bottomBar2.dart';
import 'package:food_recommendation/botttomNavigation/profile2.dart';
import 'package:food_recommendation/main.dart';

class detailPage2 extends StatefulWidget {
  final DocumentSnapshot post;
  detailPage2({this.post});
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<detailPage2> {
  var dishColor;
  var dishIcon;
  var iconColor;
  @override
  Widget build(BuildContext context) {
    if (widget.post.data["dish"] == "veg") {
      dishColor = Colors.green;
    } else if (widget.post.data["dish"] == "non-veg") {
      dishColor = Colors.red;
    } else {
      dishColor = Colors.green;
    }
    if (widget.post.data["type"] == "food") {
      dishIcon = FontAwesomeIcons.utensils;
      iconColor = Colors.redAccent;
    } else if (widget.post.data["type"] == "beverage") {
      dishIcon = FontAwesomeIcons.glassMartini;
      iconColor = Colors.blueAccent;
    } else if (widget.post.data["type"] == "dessert") {
      dishIcon = FontAwesomeIcons.iceCream;
      iconColor = Colors.pink;
    } else {
      dishIcon = FontAwesomeIcons.utensils;
      iconColor = Colors.amber;
    }

    String stepsNew = widget.post.data["stepsNew"];
    var stepsNewArr = stepsNew.split(' # ');

    String IngredientStepsNew = widget.post.data["IngredientStepsNew"];
    var IngredientStepsNewArr = IngredientStepsNew.split(' # ');

    //String unitNew=widget.post.data["unitNew"];
    //var unitNewArr=unitNew.split(' # ');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 3),
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
          backgroundColor: Colors.transparent,
          flexibleSpace: SafeArea(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 3.3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(widget.post.data["imageURL"])),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tooltip(
                    message: "${widget.post.data["name"]}",
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 2), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          dishIcon,
                                          color: iconColor,
                                          size: 27,
                                        ),
                                      ),
                                    ),
                                    new Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: Text(
                                              widget.post.data["name"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            widget.post.data["cuisine"],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "Servings: ${widget.post.data["serving"]}",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    ),
                                    new Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: dishColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(.05),
              blurRadius: 5.0,
              spreadRadius: 3.0,
              offset: Offset(
                0,
                -2,
              ),
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Want to Try?",
                        style: TextStyle(color: Colors.white),
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(32.0))),
                                content: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "The dish will be added to your recipe book!\n(If you accept)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        RawMaterialButton(
                                          shape: new CircleBorder(),
                                          elevation: 4.0,
                                          fillColor: Colors.lightBlueAccent,
                                          padding: const EdgeInsets.all(15.0),
                                          child: new Icon(
                                            FontAwesomeIcons.check,
                                            color: Colors.white,
                                            size: 25.0,
                                          ),
                                          onPressed: () {
                                            Firestore.instance
                                                .collection("users")
                                                .document(userid)
                                                .collection("cart")
                                                .document(
                                                    widget.post.data["name"])
                                                .setData({
                                              "name": widget.post.data["name"],
                                              "prepTime":
                                                  widget.post.data["prepTime"],
                                              "imageURL":
                                                  widget.post.data["imageURL"],
                                              "readyTime":
                                                  widget.post.data["readyTime"],
                                              "serving":
                                                  widget.post.data["serving"],
                                              "cuisine":
                                                  widget.post.data["cuisine"],
                                              "description": widget
                                                  .post.data["description"],
                                              "type": widget.post.data["type"],
                                              "Ingredients": widget
                                                  .post.data["Ingredients"],
                                              "IngredientQuantity": widget.post
                                                  .data["IngredientQuantity"],
                                              "dish": widget.post.data["dish"],
                                              "stepsNew":
                                                  widget.post.data["stepsNew"],
                                              "searchKey":
                                                  widget.post.data["searchKey"],
                                              "IngredientStepsNew": widget.post
                                                  .data["IngredientStepsNew"],
                                              "unitNew":
                                                  widget.post.data["unitNew"],
                                            });
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        bottomBar2()),
                                                (_) => false);
                                            /*Flushbar(
                                            backgroundColor: Colors.blueAccent,
                                            message: 'The dish has been added to your cart.',
                                            duration: Duration(seconds: 3),
                                          )..show(context);*/
                                          },
                                        ),
                                        RawMaterialButton(
                                          shape: new CircleBorder(),
                                          elevation: 4.0,
                                          fillColor: Colors.redAccent,
                                          padding: const EdgeInsets.all(15.0),
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
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Dont Want to Try?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onTap: Navigator.of(context).pop,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 105,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(widget.post.data["prepTime"].toString(),
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        SizedBox(height: 2),
                        Text(
                          'Preperation\nTime',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 105,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(widget.post.data["readyTime"].toString(),
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        SizedBox(height: 2),
                        Text(
                          'Ready\nTime',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 105,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(widget.post.data["Ingredients"].length.toString(),
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        SizedBox(height: 2),
                        Text(
                          'Ingredients\nRequired',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, bottom: 5, top: 0),
              child: Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                widget.post.data["description"],
                style: TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 15, height: 1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, bottom: 5, top: 15),
              child: Text(
                "Ingredients Required",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, bottom: 5, top: 0),
              child: Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.post.data["Ingredients"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8, top: 2),
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: iconColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                                  "${widget.post.data["Ingredients"][index][0].toUpperCase()}"
                                  "${widget.post.data["Ingredients"][index].substring(1)}")),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, bottom: 5, top: 15),
              child: Text(
                "Ingredients Steps",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Column(
              children: List.generate(IngredientStepsNewArr.length - 1, (i) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20, top: 8, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: iconColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10, left: 10, right: 10),
                      child: Center(
                          child: Text(
                        "${IngredientStepsNewArr[i][0].toUpperCase()}"
                        "${IngredientStepsNewArr[i].substring(1)}",
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                );
                ;
              }),
            ),
            /*Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5,top:15),
              child: Text("Ingredient Quantities",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            ),
            Column(
              children: List.generate(widget.post.data["Ingredients"].length,(i){
                return Padding(
                  padding: const EdgeInsets.only(top: 8,right: 20,left:20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color:iconColor,width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child:new RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text:"${widget.post.data["Ingredients"][i][0].toUpperCase()}""${widget.post.data["Ingredients"][i].substring(1)}",
                                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.black)),
                                TextSpan(text: " : ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(text: "${widget.post.data["IngredientQuantity"][i]}",
                                    style: TextStyle(color: Colors.black,fontSize: 15)),
                                TextSpan(text: " ${unitNewArr[i]}",
                                    style: TextStyle(color: Colors.black,fontSize: 15)),
                              ],
                            ),
                          ), //Text("${widget.post.data["Ingredients"][i][0].toUpperCase()}""${widget.post.data["Ingredients"][i].substring(1)} : ${widget.post.data["IngredientQuantity"][i]} grams/ml"),
                        ),
                      ),
                      new Spacer()
                    ],
                  ),
                );;
              }),

            ),*/
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: iconColor,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Show full Recipe steps",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        showGeneralDialog(
                            barrierDismissible: false,
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            context: context,
                            pageBuilder: (BuildContext context,
                                Animation animation,
                                Animation secondAnimation) {
                              return Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  height:
                                      MediaQuery.of(context).size.height - 60,
                                  color: Colors.white70,
                                  child: Center(
                                    child: ListView.builder(
                                        itemCount: stepsNewArr.length - 1,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft:
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                bottomLeft:
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              bottom: 10,
                                                              left: 10,
                                                              right: 20),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 70,
                                                            child: Text(
                                                              'Step',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 70,
                                                            child: Text(
                                                              '${index + 1}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 40,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: colorIcon,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                        ),
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2) +
                                                            50,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            '${stepsNewArr[index][0].toUpperCase()}' +
                                                                stepsNewArr[
                                                                        index]
                                                                    .substring(
                                                                        1),
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'acme',
                                                                color: Colors
                                                                    .black,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              );
                            });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
