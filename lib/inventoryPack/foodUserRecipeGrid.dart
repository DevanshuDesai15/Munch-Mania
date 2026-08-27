import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage2.dart';
import 'package:food_recommendation/main.dart';

class foodUserRecipeGrid extends StatefulWidget {
  @override
  _foodUserRecipeGridState createState() => _foodUserRecipeGridState();
}

class _foodUserRecipeGridState extends State<foodUserRecipeGrid> {
  Future getPosts() async {
    final rows = await supabase
        .from('house_recipes')
        .select()
        .eq('user_id', userid)
        .eq('category', 'food');
    return rows;
  }

  navigateToDetail(Map<String, dynamic> post) {
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
                } else if (snapshot.data!.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: <Widget>[
                      Center(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: FaIcon(
                                FontAwesomeIcons.exclamation,
                                color: Colors.blue.shade100,
                                size: (MediaQuery.of(context).size.width) / 2,
                              ),
                            ),
                            Container(
                              child: Text(
                                'You Food Recipe list is empty!\nYou should add one now.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: 2,
                                  color: Colors.blue.shade100,
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
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (_, index) {
                              final data = snapshot.data![index] as Map<String, dynamic>;
                              if (data["dish"] == "veg") {
                                color = Colors.green;
                              } else if (data["dish"] ==
                                  "non-veg") {
                                color = Colors.red;
                              } else {
                                color = Colors.green;
                              }
                              return new Container(
                                child: GestureDetector(
                                  onTap: () =>
                                      navigateToDetail(snapshot.data![index]),
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
                                                            (snapshot.data![0] as Map<String, dynamic>)["image_url"])),
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
                                                                                new FaIcon(
                                                                              FontAwesomeIcons.check,
                                                                              color: Colors.white,
                                                                              size: 25.0,
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              await supabase.from('house_recipes').delete().eq('id', data['id']);
                                                                              setState(() {
                                                                                getPosts();
                                                                              });
                                                                              await supabase.storage.from('house-recipe-images').remove(['$userid/${data["name"]}.jpg']);
                                                                              final profile = await supabase.from('profiles').select('recipe_uploaded').eq('id', userid).single();
                                                                              final currentRecipeUploaded = (profile['recipe_uploaded'] as int?) ?? 0;
                                                                              await supabase.from('profiles').update({
                                                                                'recipe_uploaded': currentRecipeUploaded - 1,
                                                                              }).eq('id', userid);
                                                                              Navigator.pop(context);
                                                                              /*Flushbar(
                                                                                backgroundColor: Colors.redAccent,
                                                                                message: 'Removed "${data["name"]}" from your Recipe List',
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
                                                                                new FaIcon(
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
                                                        data["name"],
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
                                                          FaIcon(
                                                            FontAwesomeIcons
                                                                .caretRight,
                                                            size: 20.0,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(width: 2.0),
                                                          Text(
                                                            data[
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
                                //title: Text(data["productName"]),
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
