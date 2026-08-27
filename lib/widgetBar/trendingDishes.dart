import 'package:flutter/material.dart';
import 'package:food_recommendation/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_recommendation/botttomNavigation/home_screen.dart';
import 'package:food_recommendation/expireyRecommendation/recommendationThroughExpirey.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage2.dart';
import 'package:food_recommendation/seeAll/seeAllTop.dart';

class trendingDishes extends StatefulWidget {
  @override
  _trendingDishesState createState() => _trendingDishesState();
}

class _trendingDishesState extends State<trendingDishes> {
  late Future _trendingDishData, _newlyAddedData;
  Future<List<Map<String, dynamic>>> getProfileData() async {
    final data = await supabase
        .from('recipes')
        .select()
        .eq('category', dishType!)
        .limit(5);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> getNewData() async {
    final data = await supabase
        .from('recipes')
        .select()
        .eq('category', dishType!)
        .order('created_at', ascending: false)
        .limit(5);
    return List<Map<String, dynamic>>.from(data);
  }

  @override
  void initState() {
    super.initState();
    _trendingDishData = getProfileData();
    _newlyAddedData = getNewData();
  }

  navigateToDetail(Map<String, dynamic> post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => detailPage2(post: post)));
  }

  var color;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => recommendationThroughExpirey())),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.red.shade300,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Want Food\nRecommendations?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "(According to expiry)",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 10),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 / 1.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(40)),
                      color: Colors.red.shade300,
                      image: DecorationImage(
                        image: AssetImage("assets/food2.jpeg"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.red.shade300,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        FutureBuilder(
            future: _trendingDishData,
            builder: (
              _,
              snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    child: Center(
                        child: SpinKitWave(
                            color: Colors.amber, type: SpinKitWaveType.start)),
                  ),
                );
              } else {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              'Top 5 Recipes',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => seeAllTop()),
                            ),
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data[index]["dish"] == "veg") {
                            color = Colors.green;
                          } else if (snapshot.data[index]["dish"] ==
                              "non-veg") {
                            color = Colors.red;
                          } else {
                            color = Colors.green;
                          }
                          return Tooltip(
                            message: snapshot.data[index]["name"],
                            child: GestureDetector(
                              onTap: () =>
                                  navigateToDetail(snapshot.data[index]),
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                width: 220.0,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 25.0,
                                      child: Container(
                                        height: 120.0,
                                        width: 210.0,
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${snapshot.data[index]["ingredients"].length} Ingredients Required',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    ["description"],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 10.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                height: 180.0,
                                                width: 180.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data[index]
                                                        ["image_url"]),
                                                    fit: BoxFit.cover,
                                                    alignment:
                                                        Alignment.topCenter,
                                                  ),
                                                ),
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
                                                    blurRadius:
                                                        10.0, // has the effect of softening the shadow
                                                    spreadRadius:
                                                        2.0, // has the effect of extending the shadow
                                                    offset: Offset(
                                                      2.0, // horizontal, move right 10
                                                      2.0, // vertical, move down 10
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
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${snapshot.data[index]["name"][0].toUpperCase()}'
                                                  '${snapshot.data[index]["name"].substring(1)}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.2,
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .caretRight,
                                                      size: 20.0,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 2.0),
                                                    Text(
                                                      '${snapshot.data[index]["cuisine"][0].toUpperCase()}'
                                                      '${snapshot.data[index]["cuisine"].substring(1)}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }),
        FutureBuilder(
            future: _newlyAddedData,
            builder: (
              _,
              snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(),
                );
              } else {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              'Recently Added',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => seeAllTop()),
                            ),
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data[index]["dish"] == "veg") {
                            color = Colors.green;
                          } else if (snapshot.data[index]["dish"] ==
                              "non-veg") {
                            color = Colors.red;
                          } else {
                            color = Colors.green;
                          }
                          return Tooltip(
                            message: snapshot.data[index]["name"],
                            child: GestureDetector(
                              onTap: () =>
                                  navigateToDetail(snapshot.data[index]),
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                width: 220.0,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 25.0,
                                      child: Container(
                                        height: 120.0,
                                        width: 210.0,
                                        decoration: BoxDecoration(
                                          color: Colors.amber.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${snapshot.data[index]["ingredients"].length} Ingredients Required',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    ["description"],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 10.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                height: 180.0,
                                                width: 180.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data[index]
                                                        ["image_url"]),
                                                    fit: BoxFit.cover,
                                                    alignment:
                                                        Alignment.topCenter,
                                                  ),
                                                ),
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
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${snapshot.data[index]["name"][0].toUpperCase()}'
                                                  '${snapshot.data[index]["name"].substring(1)}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.2,
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .caretRight,
                                                      size: 20.0,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 2.0),
                                                    Text(
                                                      '${snapshot.data[index]["cuisine"][0].toUpperCase()}'
                                                      '${snapshot.data[index]["cuisine"].substring(1)}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }),
      ]),
    );
  }
}
