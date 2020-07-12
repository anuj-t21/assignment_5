import './user_profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Some Travellers'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.of(context).pushNamed(UserProfile.routeName);
              }),
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
