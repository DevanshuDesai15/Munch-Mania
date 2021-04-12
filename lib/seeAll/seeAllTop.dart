import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/botttomNavigation/home_screen.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage2.dart';

const String testDevice = "Mobile Id";

class seeAllTop extends StatefulWidget {
  @override
  _seeAllTopState createState() => _seeAllTopState();
}

class _seeAllTopState extends State<seeAllTop> {
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _products = [];
  bool _loadingProducts = true;
  int _per_page = 10;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable = true;

  getProducts() async {
    Query q = _firestore
        .collection("recipes")
        .document(dishType)
        .collection(dishAll)
        .orderBy("name")
        .limit(_per_page);
    setState(() {
      _loadingProducts = true;
    });
    QuerySnapshot querySnapshot = await q.getDocuments();
    _products = querySnapshot.documents;
    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    setState(() {
      _loadingProducts = false;
    });
  }

  getMoreProducts() async {
    print("more called");
    if (_moreProductsAvailable == false) {
      print("no more products");
      return;
    }
    if (_gettingMoreProducts == true) {
      return;
    }
    _gettingMoreProducts = true;
    Query q = _firestore
        .collection("recipes")
        .document(dishType)
        .collection(dishAll)
        .orderBy("name")
        .startAfter([_lastDocument.data["name"]]).limit(_per_page);
    QuerySnapshot querySnapshot = await q.getDocuments();
    if (querySnapshot.documents.length < _per_page) {
      _moreProductsAvailable = false;
    }
    _lastDocument = querySnapshot.documents[querySnapshot.documents.length];
    _products.addAll(querySnapshot.documents);
    setState(() {
      _gettingMoreProducts = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        getMoreProducts();
      }
    });
    getProducts();
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => detailPage2(post: post)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  var color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(135.0),
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
                  height: 55,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 60.0),
                  child: Text(
                    'Seems like you are a foodie. Choose your dish now!',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 16,
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
      backgroundColor: Colors.white,
      body: _loadingProducts == true
          ? Container(
              child: Center(
                  child: SpinKitWave(
                      color: Colors.lightBlueAccent,
                      type: SpinKitWaveType.start)),
            )
          : Container(
              child: _products.length == 0
                  ? Center(
                      child: Text("No Products to show"),
                    )
                  : Column(
                      children: <Widget>[
                        new Expanded(
                          child: new GridView.builder(
                              controller: _scrollController,
                              itemCount: _products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (_, index) {
                                if (_products[index].data["dish"] == "veg") {
                                  color = Colors.green;
                                } else if (_products[index].data["dish"] ==
                                    "non-veg") {
                                  color = Colors.red;
                                } else {
                                  color = Colors.green;
                                }
                                return Tooltip(
                                  message: _products[index].data["name"],
                                  child: new Container(
                                    child: GestureDetector(
                                      onTap: () =>
                                          navigateToDetail(_products[index]),
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
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: Image.network(
                                                          _products[index]
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
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.white,
                                                              blurRadius: 10.0,
                                                              spreadRadius: 2.0,
                                                              offset: Offset(
                                                                2.0,
                                                                2.0,
                                                              ),
                                                            )
                                                          ],
                                                          shape:
                                                              BoxShape.circle,
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
                                                            _products[index]
                                                                .data["name"],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing:
                                                                  1.2,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: <Widget>[
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .caretRight,
                                                                size: 20.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              SizedBox(
                                                                  width: 2.0),
                                                              Text(
                                                                _products[index]
                                                                        .data[
                                                                    "name"],
                                                                style:
                                                                    TextStyle(
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
                    )),

      /*FutureBuilder(
          future: _seeAllBevData,
          builder: ( _ ,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                    child: SpinKitWave(
                        color: Colors.lightBlueAccent,
                        type: SpinKitWaveType.start)
                ),
              );
            } else {
              return new Column(
                children: <Widget>[
                  new Expanded(
                    child: new GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:2),
                        itemBuilder: (_, index) {
                          if(snapshot.data[index].data["dish"]=="veg"){
                            color=Colors.green;
                          }
                          else if(snapshot.data[index].data["dish"]=="non-veg"){
                            color=Colors.red;
                          }
                          else{
                            color=Colors.green;
                          }
                          return Tooltip(
                            message: snapshot.data[index].data["name"],
                            child: new Container(
                              child: GestureDetector(
                                onTap: ()=>navigateToDetail(snapshot.data[index]),
                                child: new GridTile(
                                  child:Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                                height:  MediaQuery.of(context).size.width/2.2,
                                                width:  MediaQuery.of(context).size.width/2.2,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  child: Image.network(snapshot.data[index].data["imageURL"],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 10,right:10,
                                                child:Container(
                                                  height: 25,width:25,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        blurRadius: 10.0,
                                                        spreadRadius: 2.0,
                                                        offset: Offset(2.0, 2.0,),
                                                      )
                                                    ],
                                                    shape: BoxShape.circle,
                                                    color:color,
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
                                                      snapshot.data[index].data["name"],
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
                                                          snapshot.data[index].data["name"],
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
                              //title: Text(snapshot.data[index].data["productName"]),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          }),*/
    );
  }
}
