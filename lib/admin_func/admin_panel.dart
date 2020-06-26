import 'package:country_dairy/admin_func/add_city.dart';
import 'package:country_dairy/admin_func/add_product.dart';
import 'package:country_dairy/modals/city.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Admin Panel",
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
                height: 36,
              ),
              Image.asset("assets/icon.png"),
              SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddCity()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                  decoration: BoxDecoration(
                      color: Colors.indigo[400],
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "Add New City OR Areas",
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddProduct()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "Add New Product OR Category",
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
