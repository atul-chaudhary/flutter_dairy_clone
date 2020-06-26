import 'package:country_dairy/modals/city.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'add_areas_inside_city.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_dairy/constants/constrants.dart';
import 'package:path/path.dart' as Path;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddCity extends StatefulWidget {
  @override
  _AddCityState createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  String cityName;
  File _image;
  TextEditingController textEditingController = TextEditingController();
  final picker = ImagePicker();
  String _uploadedFileURL;

  //final ProgressDialog pr = ProgressDialog(context);

  //function for picking value from gallery
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
  }

  //clear textfieldtext
  void clearText() {
    textEditingController.value = TextEditingValue(text: "");
  }

  Future uploadFile() async {
    StorageReference storageReference = Constants.storageInstance
        .ref()
        .child('city/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    //print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      _uploadedFileURL = fileURL;
    });
  }

  void flutterToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Future<bool> uploadData(dataMap) async {
    final snapShot = await Constants.fireStoreInstance
        .collection('city')
        .document(cityName.toLowerCase())
        .get();

    if (snapShot.exists) {
      //it exists
      flutterToast("City Name Already Exist");
    } else {
      //not exists
      uploadFile();
      await Constants.fireStoreInstance
          .collection("city")
          .document(cityName.toLowerCase())
          .setData(dataMap)
          .catchError((error) {
        print(error);
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //final city = Provider.of<City>(context, listen: false);
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(message: "adding data to DB");
    return ChangeNotifierProvider(
      create: (context) => City(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Add New City",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 26,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    hintText: "Add New City Name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide:
                          BorderSide(color: Colors.indigo[400], width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.indigo[400]),
                    ),
                    //border: InputBorder()
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                  controller: textEditingController,
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Consumer<City>(
                builder: (context, city, child) => Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[200]),
                  child: (city.image == null)
                      ? Image.asset("assets/city_icon.png")
                      : Image.file(city.image),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Consumer<City>(
                builder: (context, city, child) => GestureDetector(
                  onTap: () async {
                    await getImage();
                    city.setFileImage(_image);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Select Icon from Gallery",
                      style: TextStyle(
                          color: Colors.indigo[400],
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Consumer<City>(
                builder: (context, city, child) => GestureDetector(
                  onTap: () async {
                    //functionality for uploading the data
                    if (cityName == null && _image == null) {
                      //cityName = null;
                      flutterToast("First Enter Details");
                    } else if (cityName == null && _image != null) {
                      flutterToast("First Enter Details");
                    } else if (cityName != null && _image == null) {
                      flutterToast("First Enter Details");
                    } else {
                      if (cityName != null && _image != null) {
                        await pr.show();
                        //await uploadFile();
                        var dataMap = {
                          "cityId": "null",
                          "cityName": cityName.toLowerCase(),
                          "cityIcon": _uploadedFileURL,
                          "areas": null,
                          "extra1": null,
                          "extra2": null,
                          "extra3": null,
                          "extra4": null,
                        };
                        if (await uploadData(dataMap)) {
                          clearText();
                          city.clearImage();
                          await pr.hide();
                        }
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                    decoration: BoxDecoration(
                        color: Colors.indigo[400],
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Add City with Icon",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "OR",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddAreasInCity()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "Add Areas Inside a City",
                    style: TextStyle(
                      color: Colors.indigo[400],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
