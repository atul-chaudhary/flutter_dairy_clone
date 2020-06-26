import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_provider/impli1/falvor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider/impli2/yoman.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// first implementation of provider
//class _HomeState extends State<Home> {
//  @override
//  Widget build(BuildContext context) {
//    //final avor=Provider.of<Flavor>(context);
//    final counterValue = Provider.of<Counter>(context);
//    return Scaffold(
//      body: Column(
//        children: <Widget>[
//          Text("${counterValue.value}"),
//          FloatingActionButton(
//            onPressed: counterValue.increment,
//            child: Icon(Icons.add),
//          )
//        ],
//      ),
//    );
//  }
//}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //final avor=Provider.of<Flavor>(context);
    final counterValue = Provider.of<Counter>(context, listen: false);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Consumer<Counter>(
              builder: (context, counterValue, child) =>
                  Text("${counterValue.value}")),
          FloatingActionButton(
            onPressed: counterValue.increment,
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
