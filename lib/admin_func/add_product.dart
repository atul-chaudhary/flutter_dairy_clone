import 'dart:ffi';

import 'package:country_dairy/admin_func/add_product_inside_category.dart';
import 'package:country_dairy/constants/constrants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String productCategory;
  TextEditingController textEditingController = TextEditingController();

  //clear textfieldtext
  void clearText() {
    textEditingController.value = TextEditingValue(text: "");
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
        .collection('productCategory')
        .document(productCategory.toLowerCase())
        .get();

    if (snapShot.exists) {
      //it exists
      flutterToast("Category Already Exist");
    } else {
      //not exists
      //uploadFile();
      await Constants.fireStoreInstance
          .collection("productCategory")
          .document(productCategory.toLowerCase())
          .setData(dataMap)
          .catchError((error) {
        print(error);
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(message: "adding data to DB");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Add Product",
          style: TextStyle(
            color: Colors.black,
          ),
          //textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 18,
              ),
              Image.asset("assets/icon.png"),
              SizedBox(
                height: 18,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                child: TextField(
                  controller: textEditingController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    hintText: "Enter Product Category",
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
                    productCategory = value;
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () async {
//                  Navigator.of(context).push(
//                      MaterialPageRoute(builder: (context) => AddCity()));
                  var dataMap = {
                    "categoryName": productCategory,
                    "productName": null,
                    "productPrice": null,
                    "productSummary": null,
                    "productIcon": null,
                    "productEnergyDetails": null,
                    "extra1": null,
                    "extra2": null,
                    "extra3": null,
                    "extra4": null,
                  };
                  if (productCategory == null) {
                    flutterToast("Enter Product Category First");
                  } else {
                    if (productCategory != null) {
                      pr.show();
                      if (await uploadData(dataMap)) {
                        pr.hide();
                        clearText();
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
                    "Add Product Category",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
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
                      builder: (context) => AddProductDetails()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "Add New Product Inside Category",
                    style: TextStyle(
                        color: Colors.indigo[400], fontWeight: FontWeight.bold),
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
