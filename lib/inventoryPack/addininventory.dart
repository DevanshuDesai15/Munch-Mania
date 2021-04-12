import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String _selectedLocation1;
  String _selectedLocation;

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
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['productName'].startsWith(capitalizedValue)) {
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
    SearchService().searchByButtonName(checker).then((QuerySnapshot docs) {
      setState(() {
        tempSearchStore = [];
      });
      for (int i = 0; i < docs.documents.length; ++i) {
        print(docs.documents[i].data["productName"]);
        tempSearchStore.add(docs.documents[i].data);
      }
    });
    SearchService().searchByButtonType(value2).then((QuerySnapshot docs) {
      setState(() {
        tempSearchStore = tempSearchStore;
      });
      for (int i = 0; i < docs.documents.length; ++i) {
        print(docs.documents[i].data["productName"]);
        tempSearchStore.add(docs.documents[i].data);
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
                                      if (value.isEmpty) {
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
                                            onChanged: (String newValue) {
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
                                            onChanged: (String newValue) {
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
                                            if (_formKey.currentState
                                                .validate()) {
                                              if (_selectedLocation1
                                                      .isNotEmpty &&
                                                  _selectedLocation
                                                      .isNotEmpty) {
                                                Firestore.instance
                                                    .collection("admin")
                                                    .document(
                                                        "inventoryRequest")
                                                    .collection(userid)
                                                    .document((productController
                                                                .text)[0]
                                                            .toUpperCase() +
                                                        (productController.text)
                                                            .substring(1))
                                                    .setData({
                                                  'expiry': int.parse(
                                                      expiryController.text),
                                                  'productName':
                                                      (productController
                                                                  .text)[0]
                                                              .toUpperCase() +
                                                          (productController
                                                                  .text)
                                                              .substring(1),
                                                  'searchKey':
                                                      (productController
                                                              .text)[0]
                                                          .toUpperCase(),
                                                  'typeOfProduct':
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
                                          child: new Icon(
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
                                          child: new Icon(
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
                  color: Colors.blue[100],
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
                          backgroundColor: Colors.amber[300],);

                        Scaffold.of(context).showSnackBar(snackBar);*/
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
                        Scaffold.of(context).showSnackBar(snackBar);
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
  imageurll = data['imageURL'].toString();
  var col = Colors.grey;

  DateTime selectedDate;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 3),
        lastDate: DateTime(DateTime.now().year + 1));
    if (picked != null && picked != selectedDate) selectedDate = picked;
  }

  return GestureDetector(
    child: Tooltip(
      message: data["productName"],
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
                              data["productName"],
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
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 2.0),
                                Text(
                                  data["typeOfProduct"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.caretRight,
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 2.0),
                                Text(
                                  'Expiry: ${(data['expiry']).toString()} days',
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
      recipenameController.text = data['productName'];
      expiryController.text = data['expiry'].toString();
      if (data["typeOfProduct"] == "Vegetable" ||
          data["typeOfProduct"] == "Fruit") {
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
                                  if (value.isEmpty) {
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
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        Firestore.instance
                                            .collection("users")
                                            .document(userid)
                                            .collection("inventory")
                                            .document(data['productName'][0]
                                                    .toUpperCase() +
                                                data['productName']
                                                    .substring(1))
                                            .setData({
                                          'productName': data['productName'][0]
                                                  .toLowerCase() +
                                              data['productName'].substring(1),
                                          'imageURL': data['imageURL'],
                                          'quantity': int.parse(
                                              quantityController.text),
                                          'typeOfProduct':
                                              data['typeOfProduct'],
                                          'expiry':
                                              int.parse(expiryController.text),
                                          'unit': data['unit'],
                                          //'timestampOfDateAdded':DateTime.now(),
                                          //'presentDate':DateTime.now(),
                                          'expiringOn': DateTime.now().add(
                                              new Duration(
                                                  days: int.parse(
                                                      expiryController.text))),
                                          'expiringIn':
                                              int.parse(expiryController.text),
                                        });
                                        Firestore.instance
                                            .collection("users")
                                            .document(userid)
                                            .collection("PersonalDetails")
                                            .document("Details")
                                            .updateData({
                                          "countOfItems":
                                              FieldValue.increment(1)
                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: new Icon(
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
                                    child: new Icon(
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
                                      color: Colors.green[100],
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
                                  onPressed: () {
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
                                                            child: new Icon(
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
                                    Firestore.instance
                                        .collection("users")
                                        .document(userid)
                                        .collection("inventory")
                                        .document(data['productName'][0]
                                                .toUpperCase() +
                                            data['productName'].substring(1))
                                        .setData({
                                      'productName':
                                          data['productName'][0].toLowerCase() +
                                              data['productName'].substring(1),
                                      'imageURL': data['imageURL'],
                                      'quantity':
                                          int.parse(quantityController.text),
                                      'typeOfProduct': data['typeOfProduct'],
                                      'expiry':
                                          int.parse(expiryController.text),
                                      'unit': data['unit'],
                                      //'timestampOfDateAdded':DateTime.now(),
                                      //'presentDate':DateTime.now(),
                                      'expiringOn': selectedDate.add(
                                          new Duration(
                                              days: int.parse(
                                                  expiryController.text))),
                                      'expiringIn': selectedDate
                                          .add(new Duration(
                                              days: int.parse(
                                                  expiryController.text)))
                                          .difference(DateTime.now())
                                          .inDays,
                                    });
                                    Firestore.instance
                                        .collection("users")
                                        .document(userid)
                                        .collection("PersonalDetails")
                                        .document("Details")
                                        .updateData({
                                      "countOfItems": FieldValue.increment(1)
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: new Icon(
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
                                  child: new Icon(
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
