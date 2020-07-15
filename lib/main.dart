import 'package:country_dairy/admin_func/admin_login.dart';
import 'package:country_dairy/user_func/bottom.dart';
import 'package:country_dairy/user_func/user_home.dart';
import 'package:country_dairy/user_func/user_menu.dart';
import 'package:country_dairy/user_func/user_plan.dart';
import 'package:country_dairy/user_func/video.dart';
import 'package:flutter/material.dart';
import './signin_func/signin_screen.dart';
import "./user_func/home.dart";

void main() {
  runApp(
    MaterialApp(
      home: UserHomePage(),
    ),
  );
}

//MainSignInScreen

//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: ChangeNotifierProvider<BottomNavigationBarProvider>(
//        child: BottomNavigationBarExample(),
//        create: (BuildContext context) => BottomNavigationBarProvider(),
//      ),
//    );
//  }
//}
//
//class BottomNavigationBarExample extends StatefulWidget {
//  @override
//  _BottomNavigationBarExampleState createState() =>
//      _BottomNavigationBarExampleState();
//}
//
//class _BottomNavigationBarExampleState
//    extends State<BottomNavigationBarExample> {
//  var currentTab = [
//    UserHome(),
//    UserPlan(),
//    UserMenu(),
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    var provider = Provider.of<BottomNavigationBarProvider>(context);
//    print(provider);
//    return Scaffold(
//      body: currentTab[provider.currentIndex],
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: provider.currentIndex,
//        onTap: (index) {
//          provider.currentIndex = index;
//        },
//        items: [
//          BottomNavigationBarItem(
//            icon: new Icon(Icons.home),
//            title: new Text('Home'),
//          ),
//          BottomNavigationBarItem(
//            icon: new Icon(Icons.person),
//            title: new Text('Profile'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.settings),
//            title: Text('Settings'),
//          )
//        ],
//      ),
//    );
//  }
//}
//
