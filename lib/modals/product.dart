import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class Product with ChangeNotifier {
  File imageOneUri;
  File imageTwoUri;

  void setImageOne(imageLink) {
    imageOneUri = imageLink;
    notifyListeners();
  }

  void setImageTwo(imageLink) {
    imageTwoUri = imageLink;
    notifyListeners();
  }

  void clearImages(){
    imageOneUri=null;
    imageTwoUri=null;
    notifyListeners();
  }


}
