import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_dairy/constants/constrants.dart';
import 'package:country_dairy/modals/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class AddProductDetails extends StatefulWidget {
  @override
  _AddProductDetailsState createState() => _AddProductDetailsState();
}

class _AddProductDetailsState extends State<AddProductDetails> {
  String productName;
  String productPrice;
  String productSummary;
  String productCategory;
  String valueFromDropDown;
  File imageOne;
  File imageTwo;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productSummaryController = TextEditingController();
  QuerySnapshot querySnapshot;
  String uploadedImageOneUri;
  String uploadedImageSecondUri;

  Future<String> uploadFile(File imageLink, int number) async {
    String uploadedImageUrl;
    StorageReference storageReference = Constants.storageInstance
        .ref()
        .child('products/${Path.basename(imageLink.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(imageLink);
    await uploadTask.onComplete;
    //print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      uploadedImageUrl = fileURL;
    });

    return uploadedImageUrl;
  }

  Future getImageFromGallery(int imageNumber) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageNumber == 1) {
      imageOne = image;
    } else {
      imageTwo = image;
    }
  }

  void clearText() {
    productNameController.value = TextEditingValue(text: "");
    productPriceController.value = TextEditingValue(text: "");
    productSummaryController.value = TextEditingValue(text: "");
  }

  Future<bool> addProductsInsideCategory(Map dataMap) async {
    await Constants.fireStoreInstance
        .collection("productCategory")
        .document(valueFromDropDown)
        .updateData(dataMap);

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
  void initState() {
    // TODO: implement initState
    getProductCategoryList();
    super.initState();
  }

  void getProductCategoryList() async {
    querySnapshot =
        await Firestore.instance.collection("productCategory").getDocuments();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(message: "adding data to DB");

    return ChangeNotifierProvider(
      create: (context) => Product(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "Add New Product Details",
              style: TextStyle(
                color: Colors.black,
              ),
              //textAlign: TextAlign.center,
            ),
          ),
          body: (querySnapshot != null)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Select Product Category",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //implementation of drop down list
                      Container(
                        width: MediaQuery.of(context).size.width,
                        //margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.indigo[400], width: 2)),
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
                                value: document.data["categoryName"],
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      document.data["categoryName"],
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
                        height: 10,
                      ),
                      Text(
                        "Add Product Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: productNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            hintText: "Enter Product Name",
                            //filled: true,
                            //fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                  color: Colors.indigo[400], width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.indigo[400]),
                            ),
                            //border: InputBorder()
                          ),
                          onChanged: (value) {
                            productName = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Add Product Price",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: productPriceController,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            hintText: "Enter Product Price",
                            //filled: true,
                            //fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                  color: Colors.indigo[400], width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.indigo[400]),
                            ),
                            //border: InputBorder()
                          ),
                          onChanged: (value) {
                            productPrice = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Add Product Summary",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: productSummaryController,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            hintText: "Enter Product Summary",
                            //filled: true,
                            //fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                  color: Colors.indigo[400], width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.indigo[400]),
                            ),
                            //border: InputBorder()
                          ),
                          onChanged: (value) {
                            productSummary = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Add Product Icon",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Consumer<Product>(
                        builder: (context, product, child) => Container(
                            margin: EdgeInsets.fromLTRB(36, 0, 36, 0),
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: (product.imageOneUri == null)
                                ? Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 56,
                                  )
                                : Image.file(product.imageOneUri)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Consumer<Product>(
                        builder: (context, product, child) => GestureDetector(
                          onTap: () async{
                            //implementation of calling the image picker
                            await getImageFromGallery(1);
                            product.setImageOne(imageOne);
                            print(product.imageOneUri);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            //margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              "Add New Product Inside Category",
                              style: TextStyle(
                                  color: Colors.indigo[400],
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Add Energy Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Consumer<Product>(
                        builder: (context, product, child) => Container(
                            margin: EdgeInsets.fromLTRB(36, 0, 36, 0),
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: (product.imageTwoUri == null)
                                ? Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 56,
                                  )
                                : Image.file(product.imageTwoUri)),
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      Consumer<Product>(
                        builder: (context, product, child) => GestureDetector(
                          onTap: () async{
                            //implementation of calling the image picker
                            await getImageFromGallery(2);
                            product.setImageTwo(imageTwo);
                            print(product.imageTwoUri);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            //margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              "Add New Product Inside Category",
                              style: TextStyle(
                                  color: Colors.indigo[400],
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Consumer<Product>(
                        builder: (context, product, child) => GestureDetector(
                          onTap: () async {
                            if (valueFromDropDown == null ||
                                productName == null ||
                                productPrice == null ||
                                productSummary == null ||
                                product.imageOneUri == null ||
                                product.imageTwoUri == null) {
                              flutterToast("Enter All details First");
                            } else {
                              if (valueFromDropDown != null ||
                                  productName != null ||
                                  productPrice != null ||
                                  productSummary != null ||
                                  product.imageOneUri != null ||
                                  product.imageTwoUri != null) {
                                pr.show();
                                uploadedImageOneUri =
                                    await uploadFile(product.imageOneUri, 1);
                                print("image one $uploadedImageOneUri");
                                uploadedImageSecondUri =
                                    await uploadFile(product.imageTwoUri, 2);
                                print("image2 $uploadedImageSecondUri");

                                var dataMap = {
                                  "categoryName": valueFromDropDown,
                                  "prodcutIcon": uploadedImageOneUri,
                                  "productEnergyDetails":
                                      uploadedImageSecondUri,
                                  "productName": productName,
                                  "productPrice": productPrice,
                                  "productSummary": productSummary
                                };

                                if (uploadedImageOneUri != null &&
                                    uploadedImageSecondUri != null &&
                                    await addProductsInsideCategory(dataMap)) {
                                  print("in func");
                                  pr.hide();
                                  clearText();
                                  product.clearImages();
                                }
                              }
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            decoration: BoxDecoration(
                                color: Colors.indigo[400],
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              "Add Areas Inside a City",
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
                        height: 26,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
