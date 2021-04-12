import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recommendation/botttomNavigation/profile2.dart';

import 'main.dart';

class fullScreenImage extends StatefulWidget {
  @override
  _fullScreenImageState createState() => _fullScreenImageState();
}

class _fullScreenImageState extends State<fullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[300],
        title: Text(
          "Profile Picture",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    cacheImageUrl = "";
                    FirebaseStorage.instance
                        .ref()
                        .child("UserProfilePhoto")
                        .child(userid + ".jpg")
                        .delete();
                    Firestore.instance
                        .collection("users")
                        .document(userid)
                        .collection("PersonalDetails")
                        .document("Details")
                        .updateData({
                      'imageURL': "",
                    });
                  });
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: Center(child: Image.network(cacheImageUrl)),
    );
  }
}
