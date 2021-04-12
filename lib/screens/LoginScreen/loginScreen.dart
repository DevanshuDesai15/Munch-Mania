import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recommendation/Validations/validator.dart';
import 'package:food_recommendation/botttomNavigation/home_screen.dart';
import 'package:food_recommendation/screens/Home/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String pwdValid(String value) {
  Pattern pattern = r'[0-9a-zA-Z!@#$%^&*]{6,}';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value))
      return 'Minimum six characters required';
    else
      return null;
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formEmailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  TextEditingController passemailController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInput1Controller;
  TextEditingController pwdInput1Controller;
  TextEditingController confirmPwdInputController;

  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  initState() {
    passemailController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();

    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInput1Controller = new TextEditingController();
    pwdInput1Controller = new TextEditingController();
    confirmPwdInputController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  image: AssetImage("assets/back.png"), fit: BoxFit.cover)),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.fill)),
              ),
              GestureDetector(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onTap: () {
                  showGeneralDialog(
                      context: context,
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: Center(
                              child: SingleChildScrollView(
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32.0))),
                                  content: Form(
                                    key: _loginFormKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red[300],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.arrow_back,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Welcome,",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 25),
                                            child: Text(
                                              "Reinvent your love for food.",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  letterSpacing: 2),
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          enableSuggestions: true,
                                          autofocus: true,
                                          autocorrect: true,
                                          cursorColor: Colors.red[300],
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide: BorderSide(
                                                  color: Colors.red[300]),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide: BorderSide(
                                                  color: Colors.red[300]),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            hintText: 'Email',
                                            labelText: "Email",
                                            labelStyle: TextStyle(
                                                color: Colors.red[300]),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                          ),
                                          controller: emailInputController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: emailValidator,
                                        ),
                                        SizedBox(height: 18.0),
                                        TextFormField(
                                          cursorColor: Colors.red[300],
                                          decoration: InputDecoration(
                                            labelText: "Password",
                                            labelStyle: TextStyle(
                                                color: Colors.red[300]),
                                            hintText: 'Password',
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide: BorderSide(
                                                  color: Colors.red[300]),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide: BorderSide(
                                                  color: Colors.red[300]),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                          ),
                                          controller: pwdInputController,
                                          obscureText: true,
                                          validator: pwdValidator,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  if (_loginFormKey.currentState
                                                      .validate()) {
                                                    FirebaseAuth.instance
                                                        .signInWithEmailAndPassword(
                                                            email: emailInputController
                                                                .text,
                                                            password:
                                                                pwdInputController
                                                                    .text)
                                                        .then((currentUser) =>
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => _handleWindowDisplayLog())).catchError(
                                                                (err) =>
                                                                    print(err)))
                                                        .catchError((err) =>
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
                                                                        backgroundColor:
                                                                            Colors.redAccent,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(32.0))),
                                                                        content:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(15.0),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "INVALID CREDENTIALS!! \n\nIf you are a user already, check your email and password",
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: <Widget>[
                                                                                RawMaterialButton(
                                                                                  shape: new CircleBorder(),
                                                                                  elevation: 4.0,
                                                                                  fillColor: Colors.white,
                                                                                  padding: const EdgeInsets.all(15.0),
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
                                                                }));
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[300],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 20,
                                                            top: 10,
                                                            bottom: 10),
                                                    child: Text(
                                                      "Login",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  'Forgot password?',
                                                  style: TextStyle(
                                                      color: Colors.red[300]),
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Center(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              32.0))),
                                                              content: Form(
                                                                key:
                                                                    _formEmailKey,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        "Password Reset",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 20),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextFormField(
                                                                        autofocus:
                                                                            true,
                                                                        keyboardType:
                                                                            TextInputType.emailAddress,
                                                                        controller:
                                                                            passemailController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Enter Your Email-ID',
                                                                          contentPadding: EdgeInsets.fromLTRB(
                                                                              20.0,
                                                                              10.0,
                                                                              20.0,
                                                                              10.0),
                                                                          border:
                                                                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                                                        ),
                                                                        validator:
                                                                            emailValidator,
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        "If you have an account with us.\nYou will receive a mail shortly.",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            fontSize: 13),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            RawMaterialButton(
                                                                              onPressed: () {
                                                                                if (_formEmailKey.currentState.validate()) {
                                                                                  resetPassword(passemailController.text);
                                                                                  passemailController.clear();
                                                                                  Navigator.pop(context);
                                                                                }
                                                                              },
                                                                              shape: new CircleBorder(),
                                                                              elevation: 4.0,
                                                                              fillColor: Colors.lightBlueAccent,
                                                                              padding: const EdgeInsets.all(15.0),
                                                                            ),
                                                                            RawMaterialButton(
                                                                              onPressed: () {
                                                                                passemailController.clear();
                                                                                Navigator.pop(context);
                                                                              },
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 300),
                      barrierDismissible: true,
                      barrierLabel: '',
                      pageBuilder: (context, animation1, animation2) {});
                },
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  showGeneralDialog(
                      context: context,
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: Center(
                              child: SingleChildScrollView(
                                  child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(32.0))),
                                content: Form(
                                  key: _registerFormKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.amber[300],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.arrow_back,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Register Now,",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.9,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, bottom: 25),
                                          child: Text(
                                            "Food is the ingredient that binds us together!",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 2),
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        enableSuggestions: true,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          hintText: 'Full Name',
                                          labelText: "Full Name",
                                          labelStyle: TextStyle(
                                              color: Colors.amber[300]),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber[300]),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber[300]),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                        ),
                                        controller: firstNameInputController,
                                        validator: (value) {
                                          if (value.length < 3) {
                                            return "Please enter your full name.";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 18.0),
                                      TextFormField(
                                        enableSuggestions: true,
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          labelText: "Email",
                                          labelStyle: TextStyle(
                                              color: Colors.amber[300]),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber[300]),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber[300]),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                        ),
                                        controller: emailInput1Controller,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: emailValidator,
                                      ),
                                      SizedBox(height: 18.0),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                              color: Colors.amber[300]),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber[300]),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber[300]),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                        ),
                                        controller: pwdInput1Controller,
                                        obscureText: true,
                                        validator: pwdValid,
                                      ),
                                      SizedBox(height: 18.0),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Confirm Password',
                                          labelText: "Confirm Password",
                                          labelStyle: TextStyle(
                                              color: Colors.amber[300]),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber[300]),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber[300]),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                        ),
                                        controller: confirmPwdInputController,
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: pwdValid,
                                      ),
                                      SizedBox(height: 5.0),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            padding: EdgeInsets.all(15),
                                            child: Text("Register"),
                                            color: Colors.amber[300],
                                            textColor: Colors.white,
                                            onPressed: () {
                                              if (_registerFormKey.currentState
                                                  .validate()) {
                                                if (pwdInput1Controller.text ==
                                                    confirmPwdInputController
                                                        .text) {
                                                  FirebaseAuth.instance
                                                      .createUserWithEmailAndPassword(
                                                          email:
                                                              emailInput1Controller
                                                                  .text,
                                                          password:
                                                              pwdInput1Controller
                                                                  .text)
                                                      .then((currentUser) => Firestore
                                                          .instance
                                                          .collection("users")
                                                          .document(currentUser
                                                              .user.uid
                                                              .toString())
                                                          .collection(
                                                              "PersonalDetails")
                                                          .document("Details")
                                                          .setData({
                                                            'displayName':
                                                                firstNameInputController
                                                                    .text,
                                                            'recipeUsed':
                                                                int.parse('0'),
                                                            'recipeUploaded':
                                                                int.parse('0'),
                                                            'countOfItems':
                                                                int.parse('0'),
                                                            'timeStampOfDateCreated':
                                                                DateTime.now(),
                                                            'imageURL': "",
                                                            'email':
                                                                emailInput1Controller
                                                                    .text,
                                                          })
                                                          .then((result) => {
                                                                Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                _handleWindowDisplayReg()),
                                                                    (_) =>
                                                                        false),
                                                                firstNameInputController
                                                                    .clear(),
                                                                lastNameInputController
                                                                    .clear(),
                                                                emailInput1Controller
                                                                    .clear(),
                                                                pwdInput1Controller
                                                                    .clear(),
                                                                confirmPwdInputController
                                                                    .clear()
                                                              })
                                                          .catchError((err) =>
                                                              print(err)))
                                                      .catchError((err) =>
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Center(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        AlertDialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .redAccent,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(32.0))),
                                                                      content:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(15.0),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "Could not create your account!!\n\nPlease try again later!",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              RawMaterialButton(
                                                                                shape: new CircleBorder(),
                                                                                elevation: 4.0,
                                                                                fillColor: Colors.white,
                                                                                padding: const EdgeInsets.all(15.0),
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
                                                              }));
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text("Error"),
                                                          content: Text(
                                                              "The passwords do not match"),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              child:
                                                                  Text("Close"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      });
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            ),
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 300),
                      barrierDismissible: false,
                      barrierLabel: '',
                      pageBuilder: (context, animation1, animation2) {});
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: Colors.amber[300],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  _settingModalBottomSheet(context);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Login Options',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _db = Firestore.instance;
Future<FirebaseUser> googleSignIn() async {
  try {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    updateUserData(user);
    print("user name: ${user.displayName}");
    print(user);
    return user;
  } catch (error) {
    return error;
  }
}

void updateUserData(FirebaseUser user) async {
  DocumentReference ref = _db
      .collection('users')
      .document(user.uid)
      .collection("PersonalDetails")
      .document("Details");
  return ref.setData({
    'email': user.email,
    'imageURL': user.photoUrl,
    'displayName': user.displayName,
    'timeStampOfDateCreated': DateTime.now(),
  }, merge: true);
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      barrierColor: Colors.white.withOpacity(0),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Wrap(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.width / 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 6,
                      textColor: Colors.black,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 20,
                            ),
                            Text("Sign in with Google")
                          ],
                        ),
                      ),
                      onPressed: () async {
                        googleSignIn().then(
                          (result) => {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        _handleWindowDisplayGoogle()),
                                (_) => false),
                          },
                        );
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Platform.isAndroid
                        ? RaisedButton(
                            elevation: 6,
                            textColor: Colors.white,
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                  Text("Sign in with Apple")
                                ],
                              ),
                            ),
                            onPressed: () {},
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

Widget _handleWindowDisplayLog() {
  Future updateExpiryOFinventory() async {
    print("kush");
    QuerySnapshot qn = await Firestore.instance
        .collection("users")
        .document(userid)
        .collection("inventory")
        .getDocuments();

    for (int i = 0; i < qn.documents.length; i++) {
      DateTime dateTimeNow = DateTime.now();
      DateTime dateTimeThen =
          ((qn.documents[i].data['expiringOn']) as Timestamp).toDate();
      Firestore.instance
          .collection('users')
          .document(userid)
          .collection('inventory')
          .document(qn.documents[i].data["productName"][0].toUpperCase() +
              qn.documents[i].data["productName"].substring(1))
          .updateData({
        'expiringIn': dateTimeThen.difference(dateTimeNow).inDays,
      });
    }
    int count = 0;
    for (int i = 0; i < qn.documents.length; i++) {
      if (qn.documents[i].data["expiringIn"] < 0 ||
          qn.documents[i].data["quantity"] < 0) {
        Firestore.instance
            .collection('users')
            .document(userid)
            .collection("toDoList")
            .document("sections")
            .collection("appToUserTodo")
            .document(qn.documents[i].data["productName"][0].toUpperCase() +
                qn.documents[i].data["productName"].substring(1))
            .setData({
          'productName': qn.documents[i].data["productName"],
          'quantity': 0,
          'unit': qn.documents[i].data["unit"],
          'check': false,
        });
        Firestore.instance
            .collection('users')
            .document(userid)
            .collection('inventory')
            .document(qn.documents[i].data["productName"][0].toUpperCase() +
                qn.documents[i].data["productName"].substring(1))
            .delete();
        count++;
      }
    }
    Firestore.instance
        .collection("users")
        .document(userid)
        .collection("PersonalDetails")
        .document("Details")
        .updateData({"countOfItems": FieldValue.increment(-count)});
    count = 0;
    return qn.documents;
  }

  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
            backgroundColor: Colors.grey[800],
            body: Center(
                child: SpinKitWave(
                    color: Colors.white, type: SpinKitWaveType.start)));
      } else {
        if (snapshot.hasData) {
          userid = snapshot.data.uid;
          updateExpiryOFinventory();
          return home();
        } else {
          return LoginPage();
        }
      }
    },
  );
}

Widget _handleWindowDisplayReg() {
  Future updateExpiryOFinventory() async {
    print("kush");
    QuerySnapshot qn = await Firestore.instance
        .collection("users")
        .document(userid)
        .collection("inventory")
        .getDocuments();

    for (int i = 0; i < qn.documents.length; i++) {
      DateTime dateTimeNow = DateTime.now();
      DateTime dateTimeThen =
          ((qn.documents[i].data['expiringOn']) as Timestamp).toDate();
      Firestore.instance
          .collection('users')
          .document(userid)
          .collection('inventory')
          .document(qn.documents[i].data["productName"][0].toUpperCase() +
              qn.documents[i].data["productName"].substring(1))
          .updateData({
        'expiringIn': dateTimeThen.difference(dateTimeNow).inDays,
      });
    }
    int count = 0;
    for (int i = 0; i < qn.documents.length; i++) {
      if (qn.documents[i].data["expiringIn"] < 0 ||
          qn.documents[i].data["quantity"] < 0) {
        Firestore.instance
            .collection('users')
            .document(userid)
            .collection("toDoList")
            .document("sections")
            .collection("appToUserTodo")
            .document(qn.documents[i].data["productName"][0].toUpperCase() +
                qn.documents[i].data["productName"].substring(1))
            .setData({
          'productName': qn.documents[i].data["productName"],
          'quantity': 0,
          'unit': qn.documents[i].data["unit"],
          'check': false,
        });
        Firestore.instance
            .collection('users')
            .document(userid)
            .collection('inventory')
            .document(qn.documents[i].data["productName"][0].toUpperCase() +
                qn.documents[i].data["productName"].substring(1))
            .delete();
        count++;
      }
    }
    Firestore.instance
        .collection("users")
        .document(userid)
        .collection("PersonalDetails")
        .document("Details")
        .updateData({"countOfItems": FieldValue.increment(-count)});
    count = 0;
    return qn.documents;
  }

  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
            backgroundColor: Colors.grey[800],
            body: Center(
                child: SpinKitWave(
                    color: Colors.white, type: SpinKitWaveType.start)));
      } else {
        if (snapshot.hasData) {
          print("kush1");
          userid = snapshot.data.uid;
          updateExpiryOFinventory();
          return home();
        } else {
          return LoginPage();
        }
      }
    },
  );
}

Widget _handleWindowDisplayGoogle() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
            backgroundColor: Colors.grey[800],
            body: Center(
                child: SpinKitWave(
                    color: Colors.white, type: SpinKitWaveType.start)));
      } else {
        if (snapshot.hasData) {
          print(MediaQuery.of(context).size.width / 2.07);
          userid = snapshot.data.uid;
          Firestore.instance
              .collection('users')
              .document(userid)
              .collection("PersonalDetails")
              .document("Details")
              .updateData({
            'countOfItems': FieldValue.increment(0),
            'recipeUploaded': FieldValue.increment(0),
            'recipeUsed': FieldValue.increment(0),
          });
          return home();
        } else {
          return LoginPage();
        }
      }
    },
  );
}
