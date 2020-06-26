import 'package:country_dairy/admin_func/admin_login.dart';
import 'package:flutter/material.dart';
import './new_customer_login.dart';
import 'package:country_dairy/admin_func/admin_panel.dart';

class MainSignInScreen extends StatefulWidget {
  @override
  _MainSignInScreenState createState() => _MainSignInScreenState();
}

class _MainSignInScreenState extends State<MainSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/icon.png"),
            SizedBox(
              height: 36,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewCustomerLogIn()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                decoration: BoxDecoration(
                    color: Colors.indigo[400],
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "New Customer",
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
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Text(
                "Exiting Customer",
                style: TextStyle(
                    color: Colors.indigo[400], fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminLogin()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                decoration: BoxDecoration(
                    color: Colors.indigo[400],
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "Admin Login",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
