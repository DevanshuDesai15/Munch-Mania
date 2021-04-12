import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recommendation/Validations/validator.dart';
import 'package:food_recommendation/botttomNavigation/bottomBar2.dart';
import 'package:food_recommendation/botttomNavigation/home_screen.dart';
import 'package:food_recommendation/expireyRecommendation/recommendationThroughExpirey.dart';
import 'package:food_recommendation/fullScreenImage.dart';
import 'package:food_recommendation/main.dart';
import 'package:food_recommendation/screens/Home/home.dart';
import 'package:food_recommendation/screens/LoginScreen/loginScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_info/device_info.dart';

var cacheImageUrl = "";
var textColor = Colors.black;
var bgColor = Colors.white;
var circularProgress = false;

class profile2 extends StatefulWidget {
  @override
  _profile2State createState() => _profile2State();
}

class _profile2State extends State<profile2> {
  final GlobalKey<FormState> _formHelpKey = GlobalKey<FormState>();
  List<String> _locations = ['[Feedback]', '[Complaint]'];
  String _selectedLocation;
  List<String> _locations1 = [
    'Regarding UI',
    'Regarding Recipes',
    'Regarding Privacy',
  ];
  String _selectedLocation1;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formEmailKey = GlobalKey<FormState>();
  TextEditingController passemailController;

  @override
  void initState() {
    circularProgress = false;
    prof = getProfileData();
    passemailController = new TextEditingController();
    super.initState();
  }

  File _image;

  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future uploadPic(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('image Path$_image');
      circularProgress = true;
    });
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("UserProfilePhoto");
    StorageUploadTask uploadTask =
        firebaseStorageRef.child(userid + ".jpg").putFile(_image);
    var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    setState(() {
      print("Profile Picture uploaded");
      prof = getProfileData();
      Firestore.instance
          .collection("users")
          .document(userid)
          .collection("PersonalDetails")
          .document("Details")
          .updateData({"imageURL": ImageUrl});
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Profile Picture Uploaded',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.amber[300],
      ));
      circularProgress = false;
    });
  }

  Future prof;
  var fn, ln;
  Future getProfileData() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .document(userid)
        .collection("PersonalDetails")
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35.0,
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepOrangeAccent,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Recommendations",
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
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
                                    content: Form(
                                      key: _formHelpKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          Center(
                                            child: Text(
                                              "Help us serve you better!",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          new FormField(
                                            builder: (FormFieldState state) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                  hintText: 'Type of concern',
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(20.0,
                                                          10.0, 20.0, 10.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32.0)),
                                                ),
                                                child:
                                                    new DropdownButtonHideUnderline(
                                                  child: new DropdownButton(
                                                    value: _selectedLocation,
                                                    hint:
                                                        Text("Type of concern"),
                                                    isDense: true,
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        _selectedLocation =
                                                            newValue;
                                                        state.didChange(
                                                            newValue);
                                                      });
                                                    },
                                                    items: _locations
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
                                          SizedBox(
                                            height: 20,
                                          ),
                                          new FormField(
                                            builder: (FormFieldState state) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                  hintText: 'Concern',
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(20.0,
                                                          10.0, 20.0, 10.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32.0)),
                                                ),
                                                child:
                                                    new DropdownButtonHideUnderline(
                                                  child: new DropdownButton(
                                                    value: _selectedLocation1,
                                                    hint: Text("Concern"),
                                                    isDense: true,
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        _selectedLocation1 =
                                                            newValue;
                                                        state.didChange(
                                                            newValue);
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
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  RawMaterialButton(
                                                    onPressed: () {
                                                      if (_formHelpKey
                                                          .currentState
                                                          .validate()) {
                                                        if (_selectedLocation
                                                            .isNotEmpty) {
                                                          final Email email =
                                                              Email(
                                                            body:
                                                                'Feedback\n\nHi,\n#Your message',
                                                            subject:
                                                                "${_selectedLocation}:${_selectedLocation1}",
                                                            recipients: [
                                                              'developers@fodaffy.com'
                                                            ],
                                                            isHTML: false,
                                                          );
                                                          FlutterEmailSender
                                                              .send(email);
                                                          Navigator.pop(
                                                              context);
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
                                                    fillColor:
                                                        Colors.lightBlueAccent,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
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
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35.0,
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepOrangeAccent,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Sign Out",
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
            flexibleSpace: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Details",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: (MediaQuery.of(context).size.height) * .10,
          width: MediaQuery.of(context).size.width,
          child: Container(
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
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                    elevation: 6,
                    textColor: Colors.white,
                    color: Colors.white,
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.deepOrangeAccent,
                    ),
                    onPressed: () {
                      _settingModalBottomSheet(context);
                    },
                    shape: StadiumBorder()),
                RaisedButton(
                  elevation: 6,
                  textColor: Colors.white,
                  color: Colors.deepOrangeAccent,
                  child: Text("Tutorial"),
                  onPressed: () {
                    setState(() {
                      color = Colors.amber[100];
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => home()),
                    );
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                RaisedButton(
                  elevation: 6,
                  textColor: Colors.white,
                  color: Colors.deepOrangeAccent,
                  child: Text("Reset Password"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: SingleChildScrollView(
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(32.0))),
                                content: Form(
                                  key: _formEmailKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Center(
                                        child: Text(
                                          "Password Reset",
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
                                          enabled: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: passemailController,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Your Email-ID',
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0)),
                                          ),
                                          validator: emailValidator,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              RawMaterialButton(
                                                onPressed: () {
                                                  if (_formEmailKey.currentState
                                                      .validate()) {
                                                    resetPassword(
                                                        passemailController
                                                            .text);
                                                    passemailController.clear();
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
                                                fillColor:
                                                    Colors.lightBlueAccent,
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                              ),
                                              RawMaterialButton(
                                                onPressed: () {
                                                  passemailController.clear();
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
                                                padding:
                                                    const EdgeInsets.all(15.0),
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
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: FutureBuilder(
              future: prof,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: Center(
                        child: SpinKitWave(
                            color: Colors.deepOrangeAccent,
                            type: SpinKitWaveType.start)),
                  );
                } else {
                  passemailController.text = snapshot.data[0].data["email"];
                  cacheImageUrl = snapshot.data[0].data["imageURL"];
                  return Container(
                    color: bgColor,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            fullScreenImage()),
                                  );
                                },
                                child: Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.deepOrangeAccent
                                            .withOpacity(.15),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(
                                          5.0,
                                          15.0,
                                        ),
                                      )
                                    ],
                                    color:
                                        Colors.deepOrangeAccent.withOpacity(.2),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(cacheImageUrl)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        circularProgress
                                            ? CircularProgressIndicator(
                                                backgroundColor:
                                                    Colors.deepOrangeAccent,
                                                strokeWidth: 5,
                                              )
                                            : GestureDetector(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  //uploadPic(context);
                                                },
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Center(
                          child: Text(
                            '${snapshot.data[0].data["displayName"][0].toUpperCase()}'
                            '${snapshot.data[0].data["displayName"].substring(1)}',
                            style: TextStyle(
                                color: textColor,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Center(
                          child: Text(
                            snapshot.data[0].data["email"],
                            style: TextStyle(
                                color: textColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 105,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        snapshot.data[0].data["recipeUsed"]
                                            .toString(),
                                        style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                    SizedBox(height: 2),
                                    Text(
                                      'Recipes\nTried',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 13,
                                      ),
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
                                    Text(
                                        snapshot.data[0].data["recipeUploaded"]
                                            .toString(),
                                        style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                    SizedBox(height: 2),
                                    Text(
                                      'House\nRecipes',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 13,
                                      ),
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
                                    Text(
                                        snapshot.data[0].data["countOfItems"]
                                            .toString(),
                                        style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                    SizedBox(height: 2),
                                    Text(
                                      'Items In\nInventory',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              dishAll = "allFood";
                              dishType = "food";
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        recommendationThroughExpirey()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, bottom: 20),
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.red[200],
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black12.withOpacity(.05),
                                    blurRadius: 1.0,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Want Food\nRecommendations?",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "(According to expiry)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        2 /
                                        1.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(30)),
                                      color: Colors.red[100],
                                      image: DecorationImage(
                                        image: AssetImage("assets/food2.jpeg"),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        gradient: LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                          colors: [
                                            Colors.white.withOpacity(0.0),
                                            Colors.red[200],
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
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              dishAll = "allBeverages";
                              dishType = "drinks";
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        recommendationThroughExpirey()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, bottom: 20),
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.blue[200],
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black12.withOpacity(.05),
                                    blurRadius: 1.0,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Want Beverage\nRecommendations?",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "(According to expiry)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        2 /
                                        1.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(30)),
                                      color: Colors.blue[100],
                                      image: DecorationImage(
                                        image:
                                            AssetImage("assets/bevrages.jpeg"),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        gradient: LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                          colors: [
                                            Colors.white.withOpacity(0.0),
                                            Colors.blue[200],
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
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              dishAll = "allDessert";
                              dishType = "dessert";
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        recommendationThroughExpirey()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, bottom: 20),
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.pink[100],
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black12.withOpacity(.05),
                                    blurRadius: 1.0,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Want Dessert\nRecommendations?",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "(According to expiry)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        2 /
                                        1.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(30)),
                                      color: Colors.pink[100],
                                      image: DecorationImage(
                                        image: AssetImage("assets/desert.jpeg"),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        gradient: LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                          colors: [
                                            Colors.white.withOpacity(0.0),
                                            Colors.pink[100],
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
                      ],
                    ),
                  );
                }
              }),
        ));
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      barrierColor: Colors.white.withOpacity(0),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: new Text(
                      'Privacy Policy',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      _launchURL(arr[0]);
                    }),
                new ListTile(
                  leading: new Icon(
                    FontAwesomeIcons.penNib,
                    color: Colors.white,
                  ),
                  title: new Text(
                    'Terms of Service',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    _launchURL(arr[1]);
                  },
                ),
              ],
            ),
          ),
        );
      });
}

var arr = [
  'https://work.munchmania.com/#/privacy-policy',
  'https://work.munchmania.com/#/terms-of-service'
];

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
