import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage.dart';
import 'package:food_recommendation/main.dart';

class selectedDishesWidget extends StatefulWidget {
  @override
  _selectedDishesWidgetState createState() => _selectedDishesWidgetState();
}

class _selectedDishesWidgetState extends State<selectedDishesWidget> {
  List<int> _numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int? _selectedLocation;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController servingsController = new TextEditingController();

  Future<List<Map<String, dynamic>>> getSelectedDishes() async {
    final rows = await supabase
        .from('cart_items')
        .select()
        .eq('user_id', userid);
    return rows;
  }

  navigateToDetail(Map<String, dynamic> post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => detailPage(post: post)));
  }

  late Future<List<Map<String, dynamic>>> selected;
  @override
  void initState() {
    selected = getSelectedDishes();
    super.initState();
  }

  var color;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: selected,
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
          } else if (snapshot.data == null || snapshot.data!.length == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 50, right: 50, bottom: 20),
                        child: FaIcon(
                          FontAwesomeIcons.exclamation,
                          color: Colors.redAccent,
                          size: (MediaQuery.of(context).size.width) / 2,
                        ),
                      ),
                      Container(
                        child: Text(
                          'You havent selected any recipe!\nIt is never too late.\nAdd and try now!',
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
            );
          } else {
            final dishes = snapshot.data!;
            return ListView.builder(
              //shrinkWrap: true,
              itemCount: dishes.length,
              itemBuilder: (_, index) {
                final data = dishes[index];
                if (data["dish"] == "veg") {
                  color = Colors.green;
                } else if (data["dish"] == "non-veg") {
                  color = Colors.red;
                } else {
                  color = Colors.green;
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 2) / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Tooltip(
                            message: data["name"],
                            child: GestureDetector(
                              onTap: () =>
                                  navigateToDetail(dishes[index]),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) +
                                          2.5,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5.0,
                                        offset: Offset(
                                          5.0,
                                          5.0,
                                        ),
                                      )
                                    ],
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    image: DecorationImage(
                                      image: NetworkImage(data["image_url"]),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.white.withOpacity(0.0),
                                          Colors.black12,
                                        ],
                                      ),
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 30, left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            data["name"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            data["cuisine"],
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width / 2) / 10,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ))
                              ],
                              color: color,
                            ),
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width / 2) / 2.5,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: GestureDetector(
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
                                                                  32))),
                                                  content: Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Center(
                                                          child: Text(
                                                            "Tried this recipe?",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 22),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Center(
                                                          child: Text(
                                                            '(If you click on check, the recipe gets deleted from your selected dishes)',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: new FormField(
                                                            builder:
                                                                (FormFieldState
                                                                    state) {
                                                              return InputDecorator(
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Number of Servings',
                                                                  contentPadding:
                                                                      EdgeInsets.fromLTRB(
                                                                          20.0,
                                                                          10.0,
                                                                          20.0,
                                                                          10.0),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              32.0)),
                                                                ),
                                                                child:
                                                                    new DropdownButtonHideUnderline(
                                                                  child:
                                                                      new DropdownButton(
                                                                    value:
                                                                        _selectedLocation,
                                                                    hint: Text(
                                                                        "Number of Servings"),
                                                                    isDense:
                                                                        true,
                                                                    onChanged: (int?
                                                                        newValue) {
                                                                      setState(
                                                                          () {
                                                                        _selectedLocation =
                                                                            newValue;
                                                                        state.didChange(
                                                                            newValue);
                                                                      });
                                                                    },
                                                                    items: _numberList
                                                                        .map((int
                                                                            value) {
                                                                      return new DropdownMenuItem(
                                                                        value:
                                                                            value,
                                                                        child: new Text(
                                                                            value.toString()),
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                ),
                                                              );
                                                            },
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
                                                              child: new FaIcon(
                                                                FontAwesomeIcons
                                                                    .check,
                                                                color: Colors
                                                                    .white,
                                                                size: 25.0,
                                                              ),
                                                              onPressed: () async {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          (data["ingredients"]
                                                                                  as List)
                                                                              .length;
                                                                      i++) {
                                                                    final ingredientName =
                                                                        data["ingredients"][i][0]
                                                                                .toUpperCase() +
                                                                            data["ingredients"][i]
                                                                                .substring(1);
                                                                    final delta =
                                                                        (data["ingredient_quantity"][i] /
                                                                                data["serving"]) *
                                                                            _selectedLocation!;
                                                                    final invRow =
                                                                        await supabase
                                                                            .from('inventory')
                                                                            .select('id, quantity')
                                                                            .eq('user_id', userid)
                                                                            .eq('product_name',
                                                                                ingredientName)
                                                                            .maybeSingle();
                                                                    if (invRow != null) {
                                                                      final currentQty = (invRow[
                                                                                  'quantity']
                                                                              as num?) ??
                                                                          0;
                                                                      await supabase
                                                                          .from('inventory')
                                                                          .update({
                                                                        'quantity':
                                                                            currentQty - delta
                                                                      }).eq('id', invRow['id']);
                                                                    }
                                                                    servingsController
                                                                        .clear();
                                                                  }

                                                                  await supabase
                                                                      .from('cart_items')
                                                                      .delete()
                                                                      .eq('id', data['id']);
                                                                  final profile = await supabase
                                                                      .from('profiles')
                                                                      .select('recipe_used')
                                                                      .eq('id', userid)
                                                                      .single();
                                                                  final currentRecipeUsed =
                                                                      (profile['recipe_used']
                                                                              as int?) ??
                                                                          0;
                                                                  await supabase
                                                                      .from('profiles')
                                                                      .update({
                                                                    'recipe_used':
                                                                        currentRecipeUsed + 1
                                                                  }).eq('id', userid);
                                                                  setState(() {
                                                                    selected =
                                                                        getSelectedDishes();
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                  /*Flushbar(
                                                                  backgroundColor: Colors.redAccent,
                                                                  message: 'The quantities have been reduced in the inventory.\n'
                                                                      'Hope you like the repice!',
                                                                  duration: Duration(seconds: 3),
                                                                )..show(context);*/
                                                                }
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
                                                              child: new FaIcon(
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
                                              ),
                                            );
                                          });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: SingleChildScrollView(
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  32))),
                                                  content: Column(
                                                    children: <Widget>[
                                                      Center(
                                                        child: Text(
                                                          "Dont want to try it now?",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 22),
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
                                                            child: new FaIcon(
                                                              FontAwesomeIcons
                                                                  .check,
                                                              color:
                                                                  Colors.white,
                                                              size: 25.0,
                                                            ),
                                                            onPressed: () async {
                                                              await supabase
                                                                  .from(
                                                                      'cart_items')
                                                                  .delete()
                                                                  .eq('id',
                                                                      data['id']);
                                                              setState(() {
                                                                getSelectedDishes();
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                              /*Flushbar(
                                                                backgroundColor: Colors.redAccent,
                                                                message: 'Removed ${snapshot.data[index].data["name"]} from cart successfully',
                                                                duration: Duration(seconds: 3),
                                                              )..show(context);*/
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
                                                            child: new FaIcon(
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
                );
              },
            );
          }
        });
  }
}
