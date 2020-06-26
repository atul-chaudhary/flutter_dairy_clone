import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_dairy/constants/constrants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddAreasInCity extends StatefulWidget {
  @override
  _AddAreasInCityState createState() => _AddAreasInCityState();
}

class _AddAreasInCityState extends State<AddAreasInCity> {
  String cityAreas;
  List cityItems;
  String valueFromDropDown;
  QuerySnapshot querySnapshot;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getCityList();
    super.initState();
  }

  void getCityList() async {
    querySnapshot = await Firestore.instance.collection("city").getDocuments();
//    setState(() {
//      cityItems = querySnapshot.documents;
//    });
    setState(() {});
  }

  //clear textfieldtext
  void clearText() {
    textEditingController.value = TextEditingValue(text: "");
  }

  Future<bool> addAreasInsideCity() async {
    await Constants.fireStoreInstance
        .collection("city")
        .document(valueFromDropDown)
        .updateData({
      'areas': FieldValue.arrayUnion([cityAreas])
    });

    return true;
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

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(message: "adding data to DB");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Add Areas",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: (querySnapshot != null)
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Select City ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  //implementation of drop down list
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.indigo[400], width: 2)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text("Select item"),
                        value: valueFromDropDown,
                        onChanged: (value) {
                          setState(() {
                            valueFromDropDown = value;
                          });
                        },
                        items: querySnapshot.documents
                            .map((DocumentSnapshot document) {
                          return DropdownMenuItem(
                            value: document.data['cityName'],
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  document.data['cityName'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Enter the Areas Inside the City",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                    child: TextField(
                      controller: textEditingController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        hintText: "Enter Areas One by One",
                        //filled: true,
                        //fillColor: Colors.white,
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
                        cityAreas = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () async {
                      //func()
                      if (cityAreas == null || valueFromDropDown == null) {
                        flutterToast("Enter All Details first");
                      } else if (cityAreas != null &&
                          valueFromDropDown != null) {
                        pr.show();
                        if (await addAreasInsideCity()) {
                          pr.hide();
                          clearText();
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
                        "Add Areas",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
