import 'package:flutter/material.dart';
import 'package:flutter_provider/impli1/home.dart';
import 'package:flutter_provider/impli2/yoman.dart';
import 'package:provider/provider.dart';
import 'impli1/falvor.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChangeNotifierProvider<Counter>(
        create: (context) => Counter(),
        child: Home(),
      ),
    ),
  );
}
