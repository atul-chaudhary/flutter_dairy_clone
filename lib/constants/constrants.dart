import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Constants {
  static FirebaseAuth authInstance = FirebaseAuth.instance;
  static var fireStoreInstance = Firestore.instance;
  static var storageInstance = FirebaseStorage.instance;
}
