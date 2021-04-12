import 'package:flutter/material.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(75.0, 30.0, 50.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Munch Mania',
                  style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent[400]),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RaisedButton(
                    onPressed: () {
                      print('Login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.red[300],
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.red[300],
                )
              ],
            )));
  }
}
