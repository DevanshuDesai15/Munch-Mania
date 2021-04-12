import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_recommendation/main.dart';
import 'package:food_recommendation/todoPack/todoAppBar.dart';

class toDo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageWithState();
  }
}

class HomePageWithState extends State<toDo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  List<String> _locations1 = ['grams', 'ml', 'pieces'];
  String _selectedLocation1;
  Widget _createAppBar() {
    return new AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: new Text(
          "To-Do List",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          new IconButton(
              color: Colors.red,
              icon: new Icon(CupertinoIcons.add_circled),
              tooltip: 'Add Into List',
              onPressed: () {
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
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Center(
                                    child: Text(
                                      "Add to ToDo list",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: productNameController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter the product name.',
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                      ),
                                      validator: (value) {
                                        if (value.length == 0) {
                                          return "Please enter product name.";
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
                                      controller: quantityController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter the quantity.',
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                      ),
                                      validator: (value) {
                                        if (value.length == 0) {
                                          return "Please enter the quantity.";
                                        } else {
                                          return null;
                                        }
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
                                                    BorderRadius.circular(
                                                        32.0)),
                                          ),
                                          child:
                                              new DropdownButtonHideUnderline(
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
                                              items: _locations1
                                                  .map((String value) {
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          if (_formKey.currentState
                                              .validate()) {
                                            if (_selectedLocation1 != null) {
                                              Firestore.instance
                                                  .collection('users')
                                                  .document(userid)
                                                  .collection('toDoList')
                                                  .document("sections")
                                                  .collection("userTodo")
                                                  .document(
                                                      (productNameController
                                                                  .text)[0]
                                                              .toUpperCase() +
                                                          (productNameController
                                                                  .text)
                                                              .substring(1))
                                                  .setData({
                                                "productName":
                                                    productNameController.text
                                                        .toLowerCase(),
                                                'quantity': int.parse(
                                                    quantityController.text),
                                                'unit': _selectedLocation1,
                                                "check": false,
                                              });
                                              productNameController.clear();
                                              quantityController.clear();
                                              _selectedLocation1 = null;
                                              Navigator.pop(context);
                                              /*Flushbar(
                                                backgroundColor: Colors.blueAccent,
                                                message: 'Product added to user list successfully!',
                                                duration: Duration(
                                                    seconds: 3),
                                              )..show(context);*/
                                            } else {
                                              /*Flushbar(
                                                backgroundColor: Colors.redAccent,
                                                message: 'Unit is not selected!',
                                                duration: Duration(
                                                    seconds: 3),
                                              )..show(context);*/
                                            }
                                          }
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
                        ),
                      );
                    });
              }),
          /*new IconButton(
            color: Theme
                .of(context)
                .primaryColor,
            icon: new Icon(CupertinoIcons.delete),
            tooltip: 'Remove from list',
            onPressed: () {},
          )*/
        ]);
  }

  var colorBgOfCheckbox;
  var colorIconCheckbox;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _createAppBar(),
      body: todoAppBar(),
    );
  }
}
