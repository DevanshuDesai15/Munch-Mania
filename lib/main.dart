import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recommendation/botttomNavigation/bottomBar2.dart';
import 'package:food_recommendation/screens/LoginScreen/loginScreen.dart';

void main() => runApp(MyApp());
String userid = "";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MunchMania',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: _handleWindowDisplay());
  }
}

Widget _handleWindowDisplay() {
  PageController _controller = PageController(
    initialPage: 0,
  );

  Future updateExpiryOFinventory() async {
    print("update");
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

  void trial() {
    String str = "chee";
    String str2 = "Chedar cheese";
    print(str2.contains(str));
  }

  /*Future makeGetNameProduct()async{
    print("getNameProducts");
    QuerySnapshot qn=await Firestore.instance.collection("products").getDocuments();

    for(int i=0;i<qn.documents.length;i++){
      Firestore.instance.collection('getNameProducts')
          .document(qn.documents[i].data["productName"][0].toUpperCase()+qn.documents[i].data["productName"].substring(1))
          .setData({
        'productName':qn.documents[i].data["productName"][0].toUpperCase()+qn.documents[i].data["productName"].substring(1),
        'unit':qn.documents[i].data["unit"],
      });
    }
    return qn.documents;
  }*/

  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: SpinKitWave(
                    color: Colors.amber[300], type: SpinKitWaveType.start)));
      } else {
        if (snapshot.hasData) {
          userid = snapshot.data.uid;
          updateExpiryOFinventory();
          trial();
          return bottomBar2();
        } else {
          return LoginPage();
        }
      }
    },
  );
}
