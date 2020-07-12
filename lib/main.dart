import 'package:assignment_5/screens/tabs_screen.dart';

import './screens/home_screen.dart';

import './screens/edit_profile_screen.dart';

import './providers/user.dart';
import './screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assignment 5',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.pinkAccent,
        ),
        home: TabsScreen(),
        routes: {
          EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
          UserProfile.routeName: (ctx) => UserProfile(),
        },
      ),
    );
  }
}
