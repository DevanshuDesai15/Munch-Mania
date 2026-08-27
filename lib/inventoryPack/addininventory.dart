import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recommendation/main.dart';
import 'package:food_recommendation/search/searchServicies.dart';

class addininventory extends StatefulWidget {
  @override
  _searchininventoryState createState() => _searchininventoryState();
}

var colorIcon;
var colorIconBg;

class _searchininventoryState extends State<addininventory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productController = new TextEditingController();
  TextEditingController expiryController = new TextEditingController();
  TextEditingController imageURLController = new TextEditingController();
  TextEditingController vegController = new TextEditingController();
  List<String> _locations1 = ['grams', 'ml'];
  List<String> _locations = [
    'Fruit',
    'Vegetable',
    'Masala',
    'Dairy',
    'Meat',
    'Canned',
    'Bakery',
    'Branded'
  ];
  String? _selectedLocation1;
  String? _selectedLocation;

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
    if ((queryResultSet.length == 0 && value.length == 1)) {
      SearchService().searchByName(value).then((docs) {
        for (int i = 0; i < docs.length; ++i) {
          queryResultSet.add(docs[i]);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['product_name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  initiateButtonSearch(value) {
    List<String> checker;
    var value2 = value;
    value = value.toLowerCase();
    value = value + " ";
    checker = value.split(" ");
    print(checker);
    SearchService().searchByButtonName(checker).then((docs) {
      setState(() {
        tempSearchStore = [];
      });
      for (int i = 0; i < docs.length; ++i) {
        print(docs[i]["product_name"]);
        tempSearchStore.add(docs[i]);
      }
    });
    SearchService().searchByButtonType(value2).then((docs) {
      setState(() {
        tempSearchStore = tempSearchStore;
      });
      for (int i = 0; i < docs.length; ++i) {
        print(docs[i]["product_name"]);
        tempSearchStore.add(docs[i]);
      }
    });
  }

  bool isSearching = true;

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.transparent,
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
                                  BorderRadius.all(Radius.circular(32.0))),
                          content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    "Could not find your product?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 3),
                                Center(
                                  child: Text(
                                    "(Don't Worry! You can generate your request here.)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Center(
                                  child: Text(
                                    "(Our team will verify and add it to the database)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: productController,
                                    decoration: InputDecoration(
                                      hintText: 'Product Name',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter the product name";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    controller: expiryController,
                                    decoration: InputDecoration(
                                      hintText: 'Expiry Days (Approx)',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new FormField(
                                    builder: (FormFieldState state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                          hintText: 'Type of Product',
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                        ),
                                        child: new DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            value: _selectedLocation,
                                            hint: Text("Type of Product"),
                                            isDense: true,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedLocation = newValue;
                                                state.didChange(newValue);
                                              });
                                            },
                                            items:
                                                _locations.map((String value) {
                                              return new DropdownMenuItem(
                                                value: value,
                                                child: new Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new FormField(
                                    builder: (FormFieldState state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                          hintText: 'Units',
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                        ),
                                        child: new DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            value: _selectedLocation1,
                                            hint: Text("Units"),
                                            isDense: true,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedLocation1 = newValue;
                                                state.didChange(newValue);
                                              });
                                            },
                                            items:
                                                _locations1.map((String value) {
                                              return new DropdownMenuItem(
                                                value: value,
                                                child: new Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        RawMaterialButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (_selectedLocation1 !=
                                                      null &&
                                                  _selectedLocation1!
                                                      .isNotEmpty &&
                                                  _selectedLocation !=
                                                      null &&
                                                  _selectedLocation!
                                                      .isNotEmpty) {
                                                supabase
                                                    .from('inventory_requests')
                                                    .insert({
                                                  'user_id': userid,
                                                  'expiry_days': int.parse(
                                                      expiryController.text),
                                                  'product_name':
                                                      (productController
                                                                  .text)[0]
                                                              .toUpperCase() +
                                                          (productController
                                                                  .text)
                                                              .substring(1),
                                                  'search_key':
                                                      (productController
                                                              .text)[0]
                                                          .toUpperCase(),
                                                  'type_of_product':
                                                      _selectedLocation,
                                                  'unit': _selectedLocation1,
                                                });
                                                productController.clear();
                                                expiryController.clear();
                                                _selectedLocation = null;
                                                _selectedLocation1 = null;
                                                Navigator.pop(context);
                                              }
                                            }
                                          },
                                          child: new FaIcon(
                                            FontAwesomeIcons.check,
                                            color: Colors.white,
                                            size: 25.0,
                                          ),
                                          shape: new CircleBorder(),
                                          elevation: 4.0,
                                          fillColor: Colors.lightBlueAccent,
                                          padding: const EdgeInsets.all(15.0),
                                        ),
                                        RawMaterialButton(
                                          onPressed: () {
                                            productController.clear();
                                            expiryController.clear();
                                            _selectedLocation = null;
                                            _selectedLocation1 = null;
                                            Navigator.pop(context);
                                          },
                                          child: new FaIcon(
                                            FontAwesomeIcons.times,
                                            color: Colors.white,
                                            size: 25.0,
                                          ),
                                          shape: new CircleBorder(),
                                          elevation: 4.0,
                                          fillColor: Colors.redAccent,
                                          padding: const EdgeInsets.all(15.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.blue.shade100,
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
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Center(
                child: Text(
                  "Search Unsuccessful?\nGenerate a request here!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    controller: textController,
                    onChanged: (val) {
                      initiateSearch(val);
                    },
                    onSubmitted: (val) {
                      initiateButtonSearch(val);
                      setState(() {
                        isSearching = !isSearching;
                      });
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.only(left: 25.0),
                        hintText: 'Search your product.',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0))),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      isSearching
                          ? CupertinoIcons.search
                          : CupertinoIcons.clear_circled,
                      color: isSearching ? Colors.blueAccent : Colors.redAccent,
                      size: MediaQuery.of(context).size.width / 12.5,
                    ),
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        setState(() {
                          if (isSearching == false) {
                            textController.clear();
                          }
                          isSearching = !isSearching;
                        });
                        initiateButtonSearch(textController.text);
                      } else {
                        /*final snackBar = SnackBar(content: Text(
                          'Search Field is empty!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            fontFamily: 'Segoe UI',
                          ),),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.amber.shade300,);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                        final snackBar = SnackBar(
                          duration: Duration(milliseconds: 1500),
                          content: Text(
                            'Search Field is empty!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontFamily: 'Segoe UI',
                            ),
                          ),
                          backgroundColor: Colors.blueAccent,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
              ],
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

var imageurll;
Widget buildResultCard(data, BuildContext context) {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController recipenameController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController expiryController = new TextEditingController();
  imageurll = data['image_url'].toString();
  var col = Colors.grey;

  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 3),
        lastDate: DateTime(DateTime.now().year + 1));
    if (picked != null && picked != selectedDate) selectedDate = picked;
  }

  return GestureDetector(
    child: Tooltip(
      message: data["product_name"],
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.white12,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp),
            image: DecorationImage(
              image: NetworkImage(imageurll),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.black45,
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  bottom: 15.0,
                  child: Container(
                    height: 120.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 10.0,
                        bottom: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data["product_name"],
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
                                  FontAwesomeIcons.caretRight,
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 2.0),
                                Text(
                                  data["type_of_product"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.caretRight,
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 2.0),
                                Text(
                                  'Expiry: ${(data['expiry_days']).toString()} days',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  ' (approx)',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 10),
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
    ),
    onTap: () {
      recipenameController.text = data['product_name'];
      expiryController.text = data['expiry_days'].toString();
      if (data["type_of_product"] == "Vegetable" ||
          data["type_of_product"] == "Fruit") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: SingleChildScrollView(
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              "Add Product to Inventory",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              "(Expiry number is shown on the basis of our research.)",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              "(Change the expiry depending on your need.)",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              readOnly: true,
                              enabled: false,
                              controller: recipenameController,
                              decoration: InputDecoration(
                                hintText: 'Product Name',
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: expiryController,
                              decoration: InputDecoration(
                                suffix: Text("days"),
                                labelText: 'Expiry',
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.numberWithOptions(),
                                controller: quantityController,
                                decoration: InputDecoration(
                                  suffix: Text("${data["unit"]}"),
                                  labelText: 'Quantity in ${data["unit"]}',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter a quantity.";
                                  } else if (int.parse(
                                          quantityController.text) <=
                                      0) {
                                    return "Quantity should be more than zero.";
                                  } else {
                                    return null;
                                  }
                                }
                                //controller: stepsController,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RawMaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await supabase.from('inventory').insert({
                                          'user_id': userid,
                                          'product_name':
                                              data['product_name'][0]
                                                      .toLowerCase() +
                                                  data['product_name']
                                                      .substring(1),
                                          'image_url': data['image_url'],
                                          'quantity': int.parse(
                                              quantityController.text),
                                          'type_of_product':
                                              data['type_of_product'],
                                          'expiry_days':
                                              int.parse(expiryController.text),
                                          'unit': data['unit'],
                                          'expiring_on': DateTime.now()
                                              .add(new Duration(
                                                  days: int.parse(
                                                      expiryController.text)))
                                              .toIso8601String(),
                                          'expiring_in':
                                              int.parse(expiryController.text),
                                        });
                                        final profile = await supabase
                                            .from('profiles')
                                            .select()
                                            .eq('id', userid)
                                            .single();
                                        await supabase
                                            .from('profiles')
                                            .update({
                                          "count_of_items":
                                              (profile["count_of_items"] ??
                                                      0) +
                                                  1
                                        }).eq('id', userid);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: new FaIcon(
                                      FontAwesomeIcons.check,
                                      color: Colors.white,
                                      size: 25.0,
                                    ),
                                    shape: new CircleBorder(),
                                    elevation: 4.0,
                                    fillColor: Colors.lightBlueAccent,
                                    padding: const EdgeInsets.all(15.0),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: new FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.white,
                                      size: 25.0,
                                    ),
                                    shape: new CircleBorder(),
                                    elevation: 4.0,
                                    fillColor: Colors.redAccent,
                                    padding: const EdgeInsets.all(15.0),
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
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Add Product to Inventory",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "(Expiry number is shown on the basis of our research.)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "(Change the expiry depending on your need.)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: recipenameController,
                            decoration: InputDecoration(
                              hintText: 'Product Name',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: expiryController,
                            decoration: InputDecoration(
                              suffix: Text("days"),
                              labelText: 'Expiry',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: quantityController,
                            decoration: InputDecoration(
                              suffix: Text("${data["unit"]}"),
                              labelText: 'Quantity in ${data["unit"]}',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(
                              child: GestureDetector(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Date of Packaging",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.calendar_today,
                                            color: Colors.green,
                                          )
                                        ],
                                      ),
                                    )),
                                onTap: () {
                                  _selectDate(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RawMaterialButton(
                                  onPressed: () async {
                                    if (selectedDate == null) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: SingleChildScrollView(
                                                child: AlertDialog(
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  32.0))),
                                                  content: Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Center(
                                                          child: Text(
                                                            "Please select the date of packaging",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    2),
                                                          ),
                                                        ),
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
                                                            fillColor:
                                                                Colors.white,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: new FaIcon(
                                                              FontAwesomeIcons
                                                                  .check,
                                                              color: Colors
                                                                  .redAccent,
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
                                    await supabase.from('inventory').insert({
                                      'user_id': userid,
                                      'product_name':
                                          data['product_name'][0].toLowerCase() +
                                              data['product_name'].substring(1),
                                      'image_url': data['image_url'],
                                      'quantity':
                                          int.parse(quantityController.text),
                                      'type_of_product': data['type_of_product'],
                                      'expiry_days':
                                          int.parse(expiryController.text),
                                      'unit': data['unit'],
                                      'expiring_on': selectedDate!
                                          .add(new Duration(
                                              days: int.parse(
                                                  expiryController.text)))
                                          .toIso8601String(),
                                      'expiring_in': selectedDate!
                                          .add(new Duration(
                                              days: int.parse(
                                                  expiryController.text)))
                                          .difference(DateTime.now())
                                          .inDays,
                                    });
                                    final profile = await supabase
                                        .from('profiles')
                                        .select()
                                        .eq('id', userid)
                                        .single();
                                    await supabase.from('profiles').update({
                                      "count_of_items":
                                          (profile["count_of_items"] ?? 0) + 1
                                    }).eq('id', userid);
                                    Navigator.pop(context);
                                  },
                                  child: new FaIcon(
                                    FontAwesomeIcons.check,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                  shape: new CircleBorder(),
                                  elevation: 4.0,
                                  fillColor: Colors.lightBlueAccent,
                                  padding: const EdgeInsets.all(15.0),
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: new FaIcon(
                                    FontAwesomeIcons.times,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                  shape: new CircleBorder(),
                                  elevation: 4.0,
                                  fillColor: Colors.redAccent,
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }
    },
  );
}
