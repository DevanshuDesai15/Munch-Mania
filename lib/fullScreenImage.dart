import 'package:flutter/material.dart';
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
        backgroundColor: Colors.amber.shade300,
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
                onTap: () async {
                  setState(() {
                    cacheImageUrl = "";
                  });
                  await supabase.storage
                      .from('user-profile-photos')
                      .remove(["$userid.jpg"]);
                  await supabase
                      .from('profiles')
                      .update({'image_url': ''}).eq('id', userid);
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
