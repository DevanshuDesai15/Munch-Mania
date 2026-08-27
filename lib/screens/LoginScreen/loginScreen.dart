import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_recommendation/Validations/validator.dart';
import 'package:food_recommendation/screens/Home/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../main.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Web OAuth client ID (Google Cloud Console > APIs & Services >
/// Credentials), used as the ID-token audience for Supabase's Google auth
/// provider. Must match the Client ID entered in the Supabase dashboard.
const _googleServerClientId =
    '507664265448-qe121r1j7jvbtv0lug5bm79g61c77s2f.apps.googleusercontent.com';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String? pwdValid(String? value) {
  Pattern pattern = r'[0-9a-zA-Z!@#$%^&*]{6,}';
  RegExp regex = RegExp(pattern as String);
  if (value == null || value.isEmpty) {
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

  late TextEditingController passemailController;
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;

  late TextEditingController firstNameInputController;
  late TextEditingController lastNameInputController;
  late TextEditingController emailInput1Controller;
  late TextEditingController pwdInput1Controller;
  late TextEditingController confirmPwdInputController;

  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
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
                    color: Colors.red.shade300,
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
                                              color: Colors.red.shade300,
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
                                          cursorColor: Colors.red.shade300,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide: BorderSide(
                                                  color: Colors.red.shade300),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide: BorderSide(
                                                  color: Colors.red.shade300),
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
                                                color: Colors.red.shade300),
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
                                          cursorColor: Colors.red.shade300,
                                          decoration: InputDecoration(
                                            labelText: "Password",
                                            labelStyle: TextStyle(
                                                color: Colors.red.shade300),
                                            hintText: 'Password',
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide: BorderSide(
                                                  color: Colors.red.shade300),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              borderSide: BorderSide(
                                                  color: Colors.red.shade300),
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
                                                onTap: () async {
                                                  if (_loginFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    try {
                                                      await supabase.auth
                                                          .signInWithPassword(
                                                              email:
                                                                  emailInputController
                                                                      .text,
                                                              password:
                                                                  pwdInputController
                                                                      .text);
                                                      Navigator
                                                          .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      handleWindowDisplayLog()));
                                                    } catch (err) {
                                                      debugPrint(
                                                          'signInWithPassword failed: $err');
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
                                                          });
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red.shade300,
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
                                              TextButton(
                                                child: Text(
                                                  'Forgot password?',
                                                  style: TextStyle(
                                                      color: Colors.red.shade300),
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
                                                                                if (_formEmailKey.currentState!.validate()) {
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
                      pageBuilder: (context, animation1, animation2) => Container());
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
                                            color: Colors.amber.shade300,
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
                                              color: Colors.amber.shade300),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade300),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade300),
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
                                          if (value == null || value.length < 3) {
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
                                              color: Colors.amber.shade300),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade300),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade300),
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
                                              color: Colors.amber.shade300),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade300),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade300),
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
                                              color: Colors.amber.shade300),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade300),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade300),
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
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                              padding: EdgeInsets.all(15),
                                              backgroundColor:
                                                  Colors.amber.shade300,
                                              foregroundColor: Colors.white,
                                            ),
                                            child: Text("Register"),
                                            onPressed: () async {
                                              if (_registerFormKey
                                                  .currentState!
                                                  .validate()) {
                                                if (pwdInput1Controller.text ==
                                                    confirmPwdInputController
                                                        .text) {
                                                  try {
                                                    final authResponse =
                                                        await supabase.auth
                                                            .signUp(
                                                      email:
                                                          emailInput1Controller
                                                              .text,
                                                      password:
                                                          pwdInput1Controller
                                                              .text,
                                                    );
                                                    final newUser =
                                                        authResponse.user;
                                                    if (newUser == null) {
                                                      throw Exception(
                                                          'Sign up did not return a user');
                                                    }
                                                    // Best-effort: this insert needs an active
                                                    // session, which signUp() won't have yet if
                                                    // Supabase email confirmation is enabled.
                                                    // ensureProfileExists() (main.dart) is the
                                                    // real safety net once the user actually
                                                    // logs in, so a failure here must not be
                                                    // treated as signup failing.
                                                    try {
                                                      await supabase
                                                          .from('profiles')
                                                          .upsert({
                                                        'id': newUser.id,
                                                        'display_name':
                                                            firstNameInputController
                                                                .text,
                                                        'email':
                                                            emailInput1Controller
                                                                .text,
                                                        'image_url': '',
                                                      });
                                                    } catch (profileErr) {
                                                      debugPrint(
                                                          'profiles upsert on signup deferred: $profileErr');
                                                    }
                                                    firstNameInputController
                                                        .clear();
                                                    lastNameInputController
                                                        .clear();
                                                    emailInput1Controller
                                                        .clear();
                                                    pwdInput1Controller
                                                        .clear();
                                                    confirmPwdInputController
                                                        .clear();
                                                    if (authResponse.session ==
                                                        null) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    'Check your email'),
                                                                content: Text(
                                                                    'Click the confirmation link we sent you, then log in.'),
                                                                actions: [
                                                                  TextButton(
                                                                    child: Text(
                                                                        'OK'),
                                                                    onPressed: () => Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                  ),
                                                                ],
                                                              ));
                                                    } else {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      handleWindowDisplayReg()),
                                                              (_) => false);
                                                    }
                                                  } catch (err) {
                                                    debugPrint(
                                                        'signUp failed: $err');
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
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white,
                                                                              letterSpacing: 2),
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
                                                                              CircleBorder(),
                                                                          elevation:
                                                                              4.0,
                                                                          fillColor:
                                                                              Colors.white,
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              15.0),
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
                                                  }
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
                                                            TextButton(
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
                      pageBuilder: (context, animation1, animation2) => Container());
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade300,
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
                    color: Colors.green.shade300,
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

bool _googleSignInInitialized = false;

Future<void> _ensureGoogleSignInInitialized() async {
  if (_googleSignInInitialized) return;
  await GoogleSignIn.instance
      .initialize(serverClientId: _googleServerClientId);
  _googleSignInInitialized = true;
}

Future<User?> googleSignIn() async {
  try {
    await _ensureGoogleSignInInitialized();
    final GoogleSignInAccount googleSignInAccount =
        await GoogleSignIn.instance.authenticate();
    final String? idToken = googleSignInAccount.authentication.idToken;
    if (idToken == null) {
      throw Exception('Google sign-in did not return an ID token');
    }
    final AuthResponse authResult = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
    final User? user = authResult.user;
    if (user != null) {
      await updateUserData(user);
    }
    return user;
  } catch (error) {
    debugPrint('googleSignIn failed: $error');
    return null;
  }
}

Future<void> updateUserData(User user) async {
  await supabase.from('profiles').upsert({
    'id': user.id,
    'email': user.email ?? '',
    'image_url': user.userMetadata?['avatar_url'] ?? '',
    'display_name': user.userMetadata?['full_name'] ?? user.email ?? '',
  });
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 6,
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
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
                        final user = await googleSignIn();
                        if (user != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      handleWindowDisplayGoogle()),
                              (_) => false);
                        }
                      },
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
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 6,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
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

Widget _handleWindowDisplayAfterAuth() {
  return StreamBuilder<AuthState>(
    stream: supabase.auth.onAuthStateChange,
    initialData:
        AuthState(AuthChangeEvent.initialSession, supabase.auth.currentSession),
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
            backgroundColor: Colors.grey.shade800,
            body: Center(
                child: SpinKitWave(
                    color: Colors.white, type: SpinKitWaveType.start)));
      } else {
        final user = snapshot.data?.session?.user;
        if (user != null) {
          userid = user.id;
          ensureProfileExists(user);
          updateExpiryOfInventory();
          return home();
        } else {
          return LoginPage();
        }
      }
    },
  );
}

Widget handleWindowDisplayLog() => _handleWindowDisplayAfterAuth();

Widget handleWindowDisplayReg() => _handleWindowDisplayAfterAuth();

Widget handleWindowDisplayGoogle() => _handleWindowDisplayAfterAuth();
