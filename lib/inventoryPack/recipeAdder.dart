import 'dart:io';

import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_recommendation/main.dart';
import 'package:image_picker/image_picker.dart';

List<String> myList;
List<String> myGram;
List<String> myListConst;
List<String> myGramConst;

class recipeAdder extends StatefulWidget {
  @override
  _recipeAdderState createState() => _recipeAdderState();
}

class _recipeAdderState extends State<recipeAdder> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  TextEditingController recipenameController;
  TextEditingController descriptionController;
  TextEditingController cuisineController;
  TextEditingController imageURLController;
  TextEditingController prepController;
  TextEditingController readyController;
  TextEditingController vegController;
  TextEditingController servingsController;
  TextEditingController stepsController;
  TextEditingController ingredientsController;
  TextEditingController quantityController;
  TextEditingController ingredientsStepsController;
  List<String> _locations1 = ['grams', 'ml', 'pieces'];
  String _selectedLocation1;
  var unitsGrowable = new List<String>();
  var stepsGrowable = new List<String>();
  var ingredientsGrowable = new List<String>();
  var ingredientStepsGrowable = new List<String>();
  var quantityGrowable = new List<dynamic>();
  List<String> _locations = ['veg', 'non-veg'];
  List<String> _locationsForFood = ['food', 'beverage', 'dessert'];
  String _selectedLocation;
  String _selectedUnit = "grams";
  String _selectedLocationForFood;
  String typeLoction;
  String typeLoction2;
  String suffix = " # ";
  String strSteps = "";
  String strUnit = "";
  String strStepss = "";

  final dbref = Firestore.instance;
  int stepCount = 1;
  int ingredientCount = 1;
  int quantityCount = 1;
  int ingredientStepCount = 1;

  File _image;
  Future uploadPic(BuildContext context, String abc) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('image Path$_image');
    });
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("houseRecipes").child(userid);
    StorageUploadTask uploadTask =
        firebaseStorageRef.child(abc + ".jpg").putFile(_image);
    var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    setState(() {
      imageURLController.text = ImageUrl;
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Recipe Image Uploaded Successfully')));
    });
  }

  List<DocumentSnapshot> _products = [];
  getProductN() async {
    Query q = Firestore.instance.collection("getNameProducts");
    QuerySnapshot querySnapshot = await q.getDocuments();
    _products = querySnapshot.documents;
    for (int i = 0; i < _products.length; i++) {
      myList.add(_products[i].data["productName"]);
      myGram.add(_products[i].data["unit"]);
    }
  }

  Future getProductName() async {
    QuerySnapshot qn =
        await Firestore.instance.collection("getNameProducts").getDocuments();
    return qn.documents;
  }

  Future getProdName;

  @override
  initState() {
    recipenameController = new TextEditingController();
    descriptionController = new TextEditingController();
    imageURLController = new TextEditingController();
    prepController = new TextEditingController();
    readyController = new TextEditingController();
    vegController = new TextEditingController();
    servingsController = new TextEditingController();
    cuisineController = new TextEditingController();
    stepsController = new TextEditingController();
    ingredientsController = new TextEditingController();
    quantityController = new TextEditingController();
    ingredientsStepsController = new TextEditingController();

    getProdName = getProductName();
    myList = List<String>();
    myGram = List<String>();
    myListConst = List<String>();
    myGramConst = List<String>();
    getProductN();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Center(
          child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: SingleChildScrollView(
                  child: Form(
                key: _registerFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Food Name',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          controller: recipenameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a valid first name.";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Description',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                            controller: descriptionController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter a description";
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Cuisine',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          controller: cuisineController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a valid cuisine";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Preparation Time',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          controller: prepController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a valid time in minutes";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Ready Time',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          controller: readyController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a valid time in minutes";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: InputDecorator(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: _selectedLocation,
                                isDense: true,
                                hint: Text('Veg/Non-Veg'),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedLocation = newValue;
                                  });
                                },
                                items: _locations.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: InputDecorator(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: _selectedLocationForFood,
                                isDense: true,
                                hint: Text('Type of Recipe'),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedLocationForFood = newValue;
                                  });
                                },
                                items: _locationsForFood.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Servings',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          controller: servingsController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Number of Servings is required";
                            } else if (int.parse(servingsController.text) < 1) {
                              return "Servings cannot be zero or negative";
                            } else if (int.parse(servingsController.text) > 4) {
                              return "Servings should be between 1-4";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    /*Card(
                          elevation: .5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: SimpleAutoCompleteTextField(
                                          controller: ingredientsController,
                                          key: key,
                                          suggestions: myList,
                                          clearOnSubmit: false,
                                          textChanged: (text){
                                            for(int i=0;i<myList.length;i++){
                                              if(text==myList[i]){
                                                print("true/false");
                                                setState(() {
                                                  _selectedUnit=myGram[i];
                                                });
                                                break;
                                              }
                                            }
                                          },
                                          textSubmitted: (text){
                                            for(int i=0;i<myList.length;i++){
                                              if(text==myList[i]){
                                                print("true/false");
                                                setState(() {
                                                  _selectedUnit=myGram[i];
                                                });
                                                break;
                                              }
                                            }
                                          },
                                          //clearOnSubmit: false,
                                          decoration: InputDecoration(
                                            hintText: 'Ingredients',
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(32.0)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Flexible(
                                        child: TextFormField(
                                          keyboardType: TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            hintText: 'Quantity',
                                            suffix: Text(_selectedUnit),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(32.0)),
                                          ),
                                          controller: quantityController,
                                        ),
                                      ),
                                    ]),
                                SizedBox(height:10.0),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: new FormField(
                                        builder: (FormFieldState state) {
                                          return InputDecorator(
                                            decoration: InputDecoration(
                                              hintText: 'Units ${ingredientCount}',
                                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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
                                                items: _locations1.map((String value) {
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
                                    SizedBox(width: 5,),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: Text("Add"),
                                      color: Colors.lightGreenAccent,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        if(ingredientsController.text.isEmpty){
                                          final snackBar = SnackBar(content: Text('Please add the ingredient name'),duration: Duration(seconds: 1),backgroundColor: Colors.redAccent,);
                                          Scaffold.of(context).showSnackBar(snackBar);
                                        }
                                        else if(quantityController.text.isEmpty){
                                          final snackBar = SnackBar(content: Text('Please add the quantity of that ingredient'),duration: Duration(seconds: 1),backgroundColor: Colors.redAccent,);
                                          Scaffold.of(context).showSnackBar(snackBar);
                                        }
                                        else if(_selectedLocation1==null){
                                          final snackBar = SnackBar(content: Text('Please select the unit.'),duration: Duration(seconds: 1),backgroundColor: Colors.redAccent,);
                                          Scaffold.of(context).showSnackBar(snackBar);
                                        }
                                        else{
                                          final snackBar = SnackBar(content: Text('${ingredientsController.text} with ${quantityController.text} grams is added!'),duration: Duration(seconds: 1),backgroundColor: Colors.blueAccent,);
                                          Scaffold.of(context).showSnackBar(snackBar);
                                          ingredientsGrowable.add((ingredientsController.text).toLowerCase());
                                          quantityGrowable.add(int.parse(quantityController.text));
                                          unitsGrowable.add(_selectedLocation1);
                                          strUnit=strUnit+_selectedLocation1+suffix;
                                          _selectedLocation1=null;
                                          ingredientsController.clear();
                                          quantityController.clear();
                                          setState(() {
                                            ingredientCount=ingredientCount+1;
                                            quantityCount=quantityCount+1;
                                          });
                                        }
                                      },
                                    ),
                                    SizedBox(width: 5,),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: Text("Edit"),
                                      color: Colors.yellow,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: SingleChildScrollView(
                                                  child: AlertDialog(
                                                    actions: <Widget>[
                                                      GestureDetector(
                                                        onTap: (){Navigator.pop(context);},
                                                        child: Container(
                                                          width: 300,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              color: Colors.deepOrangeAccent,
                                                              borderRadius: BorderRadius.all(Radius.circular(30))
                                                          ),
                                                          child: Center(child: Text("Done",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                                        ),
                                                      ),
                                                    ],
                                                    title: Text("Edit the ingredients.\n(Swipe to remove/delete)",textAlign: TextAlign.center,),
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(32.0))) ,
                                                    content:Container(
                                                      height: 300.0,
                                                      width: 300.0,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: ingredientsGrowable.length,
                                                        itemBuilder: (context, index) {
                                                          final item = ingredientsGrowable[index];
                                                          return Dismissible(
                                                            key: Key(item),
                                                            onDismissed: (direction) {
                                                              setState(() {
                                                                ingredientsGrowable.removeAt(index);
                                                                quantityGrowable.removeAt(index);
                                                                ingredientCount=ingredientCount-1;
                                                                quantityCount=quantityCount-1;
                                                                Navigator.pop(context);
                                                                dialogagain1();
                                                              });
                                                              Scaffold.of(context)
                                                                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
                                                            },
                                                            background: Container(color: Colors.red),
                                                            child: ListTile(
                                                              title: Text('$item'),
                                                              subtitle: Text(
                                                                  'Quantity:${quantityGrowable[index]}'
                                                              ),
                                                              trailing: GestureDetector(
                                                                child: Icon(Icons.edit),
                                                                onTap: (){
                                                                  ingredientsController.text=ingredientsGrowable[index];
                                                                  quantityController.text=quantityGrowable[index].toString();
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return Center(
                                                                          child: SingleChildScrollView(
                                                                            child: AlertDialog(
                                                                              shape:RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(32.0))) ,
                                                                              content:Container(
                                                                                height: 100.0,
                                                                                width: MediaQuery.of(context).size.width-100,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Row(
                                                                                        children: <Widget>[
                                                                                          Flexible(
                                                                                            child: TextFormField(
                                                                                              decoration: InputDecoration(
                                                                                                hintText: 'Ingredients ${ingredientCount.toString()}',
                                                                                                contentPadding: EdgeInsets.fromLTRB(
                                                                                                    20.0, 10.0, 20.0, 10.0),
                                                                                                border: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(32.0)),
                                                                                              ),
                                                                                              controller: ingredientsController,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(width: 5,),
                                                                                          Flexible(
                                                                                            child: TextFormField(
                                                                                              keyboardType: TextInputType.numberWithOptions(),
                                                                                              decoration: InputDecoration(
                                                                                                hintText: 'Quantity ${quantityCount.toString()}',
                                                                                                contentPadding: EdgeInsets.fromLTRB(
                                                                                                    20.0, 10.0, 20.0, 10.0),
                                                                                                border: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(32.0)),
                                                                                              ),
                                                                                              controller: quantityController,
                                                                                            ),
                                                                                          ),
                                                                                        ]),
                                                                                    Flexible(
                                                                                      child: RaisedButton(
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(24),
                                                                                        ),
                                                                                        padding: EdgeInsets.all(15),
                                                                                        child: Text("Edited"),
                                                                                        color: Colors.lightGreenAccent,
                                                                                        textColor: Colors.white,
                                                                                        onPressed: () {
                                                                                          if(ingredientsController.text.isEmpty){
                                                                                          }
                                                                                          else if(quantityController.text.isEmpty){
                                                                                          }
                                                                                          else{
                                                                                            setState(() {
                                                                                              ingredientsGrowable[index]=((ingredientsController.text).toLowerCase());
                                                                                              quantityGrowable[index]=double.parse(quantityController.text);
                                                                                            });
                                                                                            ingredientsController.clear();
                                                                                            quantityController.clear();

                                                                                            Navigator.pop(context);
                                                                                            Navigator.pop(context);
                                                                                            dialogagain1();
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                              ),
                                                              isThreeLine: true,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),*/ //prev edited
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Flexible(
                                child: SimpleAutoCompleteTextField(
                                  controller: ingredientsController,
                                  key: key,
                                  suggestions: myList,
                                  clearOnSubmit: false,
                                  textChanged: (text) {
                                    for (int i = 0; i < myList.length; i++) {
                                      if (text == myList[i]) {
                                        print("true/false");
                                        setState(() {
                                          _selectedUnit = myGram[i];
                                        });
                                        break;
                                      }
                                    }
                                  },
                                  textSubmitted: (text) {
                                    for (int i = 0; i < myList.length; i++) {
                                      if (text == myList[i]) {
                                        print("true/false");
                                        setState(() {
                                          _selectedUnit = myGram[i];
                                        });
                                        break;
                                      }
                                    }
                                  },
                                  //clearOnSubmit: false,
                                  decoration: InputDecoration(
                                    hintText: 'Ingredients',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: TextFormField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  decoration: InputDecoration(
                                    hintText: 'Quantity',
                                    suffix: Text(_selectedUnit),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                  ),
                                  controller: quantityController,
                                ),
                              ),
                            ]),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Text("Add to Ingredients"),
                                  color: Colors.lightGreenAccent,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (ingredientsController.text.isEmpty &&
                                        quantityController.text.isEmpty) {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'Ingredient name and its quantity is missing'),
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.red,
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (ingredientsController
                                        .text.isEmpty) {
                                      final snackBar = SnackBar(
                                        content:
                                            Text('Ingredient name is missing'),
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.red,
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (quantityController
                                        .text.isEmpty) {
                                      final snackBar = SnackBar(
                                        content: Text('Quantity is missing'),
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.redAccent,
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      ingredientsGrowable.add(
                                          (ingredientsController.text)
                                              .toLowerCase());
                                      quantityGrowable.add(double.parse(
                                          quantityController.text));
                                      final snackBar = SnackBar(
                                        content: Text('Added to Ingredients!'),
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.blueAccent,
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                      ingredientsController.clear();
                                      quantityController.clear();
                                    }
                                  },
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Text("Edit"),
                                  color: Colors.yellow,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Center(
                                            child: SingleChildScrollView(
                                              child: AlertDialog(
                                                actions: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      width: 300,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .deepOrangeAccent,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                      child: Center(
                                                          child: Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                                title: Text(
                                                  "Edit the ingredients.\n(Swipe to remove/delete)",
                                                  textAlign: TextAlign.center,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                32.0))),
                                                content: Container(
                                                  height: 300.0,
                                                  width: 300.0,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        ingredientsGrowable
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final item =
                                                          ingredientsGrowable[
                                                              index];
                                                      return Dismissible(
                                                        key: Key(item),
                                                        onDismissed:
                                                            (direction) {
                                                          setState(() {
                                                            ingredientsGrowable
                                                                .removeAt(
                                                                    index);
                                                            quantityGrowable
                                                                .removeAt(
                                                                    index);
                                                            ingredientCount =
                                                                ingredientCount -
                                                                    1;
                                                            quantityCount =
                                                                quantityCount -
                                                                    1;
                                                            Navigator.pop(
                                                                context);
                                                            dialogagain1();
                                                          });
                                                          Scaffold.of(context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "$item dismissed")));
                                                        },
                                                        background: Container(
                                                            color: Colors.red),
                                                        child: ListTile(
                                                          title: Text('$item'),
                                                          subtitle: Text(
                                                              'Quantity:${quantityGrowable[index]}'),
                                                          trailing:
                                                              GestureDetector(
                                                            child: Icon(
                                                                Icons.edit),
                                                            onTap: () {
                                                              ingredientsController
                                                                      .text =
                                                                  ingredientsGrowable[
                                                                      index];
                                                              quantityController
                                                                      .text =
                                                                  quantityGrowable[
                                                                          index]
                                                                      .toString();
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Center(
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            AlertDialog(
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                                          content:
                                                                              Container(
                                                                            height:
                                                                                100.0,
                                                                            width:
                                                                                MediaQuery.of(context).size.width - 100,
                                                                            child:
                                                                                Column(
                                                                              children: <Widget>[
                                                                                Row(children: <Widget>[
                                                                                  Flexible(
                                                                                    child: TextFormField(
                                                                                      decoration: InputDecoration(
                                                                                        hintText: 'Ingredients ${ingredientCount.toString()}',
                                                                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                                                                      ),
                                                                                      controller: ingredientsController,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: TextFormField(
                                                                                      keyboardType: TextInputType.numberWithOptions(),
                                                                                      decoration: InputDecoration(
                                                                                        hintText: 'Quantity ${quantityCount.toString()}',
                                                                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                                                                      ),
                                                                                      controller: quantityController,
                                                                                    ),
                                                                                  ),
                                                                                ]),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Flexible(
                                                                                  child: RaisedButton(
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(24),
                                                                                    ),
                                                                                    padding: EdgeInsets.all(15),
                                                                                    child: Text("Edited"),
                                                                                    color: Colors.lightGreenAccent,
                                                                                    textColor: Colors.white,
                                                                                    onPressed: () {
                                                                                      if (ingredientsController.text.isEmpty) {
                                                                                      } else if (quantityController.text.isEmpty) {
                                                                                      } else {
                                                                                        setState(() {
                                                                                          ingredientsGrowable[index] = ((ingredientsController.text).toLowerCase());
                                                                                          quantityGrowable[index] = double.parse(quantityController.text);
                                                                                        });
                                                                                        ingredientsController.clear();
                                                                                        quantityController.clear();

                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                        dialogagain1();
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }).then((value) {
                                                                ingredientsController
                                                                    .clear();
                                                                quantityController
                                                                    .clear();
                                                              });
                                                            },
                                                          ),
                                                          isThreeLine: true,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ), //new
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                hintText:
                                    'Ingredient Steps ${ingredientStepCount.toString()}',
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              controller: ingredientsStepsController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Text("Add to Ingredient Steps"),
                              color: Colors.lightGreenAccent,
                              textColor: Colors.white,
                              onPressed: () {
                                if (ingredientsStepsController.text.isEmpty) {
                                  final snackBar = SnackBar(
                                      content:
                                          Text('Ingredient Step is not added'),
                                      backgroundColor: Colors.redAccent,
                                      duration: Duration(seconds: 1));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text(
                                        '${ingredientsStepsController.text} is added!'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.blueAccent,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  ingredientStepsGrowable
                                      .add(ingredientsStepsController.text);
                                  strSteps = strSteps +
                                      ingredientsStepsController.text +
                                      suffix;
                                  ingredientsStepsController.clear();
                                  setState(() {
                                    ingredientStepCount =
                                        ingredientStepCount + 1;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Steps ${stepCount.toString()}',
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              controller: stepsController,
                            ),
                            SizedBox(height: 10.0),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Text("Add to Steps"),
                              color: Colors.lightGreenAccent,
                              textColor: Colors.white,
                              onPressed: () {
                                if (stepsController.text.isEmpty) {
                                  final snackBar = SnackBar(
                                      content: Text('Step is not added'),
                                      backgroundColor: Colors.redAccent,
                                      duration: Duration(seconds: 1));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                      content: Text(
                                          '${stepsController.text} is added to steps!'),
                                      backgroundColor: Colors.blueAccent,
                                      duration: Duration(seconds: 1));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  stepsGrowable.add(stepsController.text);
                                  strStepss =
                                      strStepss + stepsController.text + suffix;
                                  stepsController.clear();
                                  setState(() {
                                    stepCount = stepCount + 1;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.blueAccent[100],
                            child: GestureDetector(
                              onTap: () {
                                uploadPic(context, recipenameController.text);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.black12,
                                      offset: new Offset(1.0, 3.0),
                                      blurRadius: 2.0,
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.all(15),
                            child: Text("Add To House Recipes"),
                            color: Colors.lightBlueAccent,
                            textColor: Colors.white,
                            onPressed: () {
                              if (_registerFormKey.currentState.validate()) {
                                if (_selectedLocation == null) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'You have not selected veg or non-veg'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.redAccent,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else if (_selectedLocationForFood == null) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'You have not selected type of dish'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.redAccent,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else if (ingredientsGrowable.length == 0) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'You have not added any ingredients'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.redAccent,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else if (ingredientStepsGrowable.length ==
                                    0) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'You have not added any ingredients steps.'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.redAccent,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else if (stepsGrowable.length == 0) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'You have not added any Steps to make the recipe'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.redAccent,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  if (_selectedLocationForFood == "beverage") {
                                    typeLoction = "drinks";
                                    typeLoction2 = "allBeverages";
                                  } else if (_selectedLocationForFood ==
                                      "food") {
                                    typeLoction = "food";
                                    typeLoction2 = "allFood";
                                  } else if (_selectedLocationForFood ==
                                      "dessert") {
                                    typeLoction = "dessert";
                                    typeLoction2 = "allDessert";
                                  }
                                  dbref
                                      .collection("users")
                                      .document(userid)
                                      .collection("HouseRecipes")
                                      .document(typeLoction)
                                      .collection(typeLoction2)
                                      .document((recipenameController.text)[0]
                                              .toUpperCase() +
                                          recipenameController.text
                                              .substring(1))
                                      .setData({
                                    'name': (recipenameController.text)[0]
                                            .toUpperCase() +
                                        recipenameController.text.substring(1),
                                    'description': descriptionController.text,
                                    'imageURL': imageURLController.text,
                                    'prepTime': int.parse(prepController.text),
                                    'readyTime':
                                        int.parse(readyController.text),
                                    'searchKey': (recipenameController.text)[0]
                                        .toUpperCase(),
                                    'type': _selectedLocationForFood,
                                    'dish': _selectedLocation,
                                    'cuisine': cuisineController.text,
                                    'serving':
                                        int.parse(servingsController.text),
                                    'Ingredients': ingredientsGrowable,
                                    'IngredientQuantity': quantityGrowable,
                                    'IngredientStepsNew': strSteps,
                                    'unitNew': strUnit,
                                    'stepsNew': strStepss,
                                  });
                                  dbref
                                      .collection("users")
                                      .document(userid)
                                      .collection("PersonalDetails")
                                      .document("Details")
                                      .updateData({
                                    "recipeUploaded": FieldValue.increment(1),
                                  });
                                  strUnit = "";
                                  strSteps = "";
                                  strStepss = "";
                                  recipenameController.clear();
                                  descriptionController.clear();
                                  cuisineController.clear();
                                  imageURLController.clear();
                                  prepController.clear();
                                  readyController.clear();
                                  servingsController.clear();
                                  vegController.clear();
                                  quantityGrowable.clear();
                                  ingredientsGrowable.clear();
                                  stepCount = 1;
                                  ingredientCount = 1;
                                  quantityCount = 1;
                                  ingredientStepCount = 1;
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Recipe has been Added to your house recipes'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.blueAccent,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  stepsGrowable.add(stepsController.text);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
        ));
  }

  Widget dialogagain1() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                actions: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                          child: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
                title: Text(
                  "Edit the ingredients.\n(Swipe to remove/delete)",
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                content: Container(
                  height: 300.0,
                  width: 300.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ingredientsGrowable.length,
                    itemBuilder: (context, index) {
                      final item = ingredientsGrowable[index];
                      return Dismissible(
                        key: Key(item),
                        onDismissed: (direction) {
                          setState(() {
                            ingredientsGrowable.removeAt(index);
                            quantityGrowable.removeAt(index);
                            ingredientCount = ingredientCount - 1;
                            quantityCount = quantityCount - 1;
                            Navigator.pop(context);
                            dialogagain1();
                          });
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("$item dismissed")));
                        },
                        background: Container(color: Colors.red),
                        child: ListTile(
                          title: Text('$item'),
                          subtitle: Text('Quantity:${quantityGrowable[index]}'),
                          trailing: GestureDetector(
                            child: Icon(Icons.edit),
                            onTap: () {
                              ingredientsController.text =
                                  ingredientsGrowable[index];
                              quantityController.text =
                                  quantityGrowable[index].toString();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: SingleChildScrollView(
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0))),
                                          content: Container(
                                            height: 100.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100,
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  Flexible(
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Ingredients ${ingredientCount.toString()}',
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
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
                                                      controller:
                                                          ingredientsController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: TextFormField(
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Quantity ${quantityCount.toString()}',
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
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
                                                      controller:
                                                          quantityController,
                                                    ),
                                                  ),
                                                ]),
                                                Flexible(
                                                  child: RaisedButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    padding: EdgeInsets.all(15),
                                                    child: Text("Edited"),
                                                    color:
                                                        Colors.lightGreenAccent,
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      if (ingredientsController
                                                          .text.isEmpty) {
                                                      } else if (quantityController
                                                          .text.isEmpty) {
                                                      } else {
                                                        setState(() {
                                                          ingredientsGrowable[
                                                                  index] =
                                                              ((ingredientsController
                                                                      .text)
                                                                  .toLowerCase());
                                                          quantityGrowable[
                                                                  index] =
                                                              double.parse(
                                                                  quantityController
                                                                      .text);
                                                        });
                                                        ingredientsController
                                                            .clear();
                                                        quantityController
                                                            .clear();

                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        dialogagain1();
                                                      }
                                                    },
                                                  ),
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
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
