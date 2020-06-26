import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class City with ChangeNotifier {
  String cityName;
  File image;

  void setFileImage(imagePath) {
    image = imagePath;
    notifyListeners();
  }

  void clearImage(){
    image=null;
    notifyListeners();
  }
}
