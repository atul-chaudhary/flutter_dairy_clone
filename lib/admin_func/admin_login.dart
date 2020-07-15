import 'package:country_dairy/admin_func/admin_panel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String adminEmailId;
  String adminPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 56,
            ),
            Image.asset("assets/icon.png"),
            SizedBox(
              height: 36,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  hintText: "Enter Admin Email",
                  //filled: true,
                  //fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.indigo[400], width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.indigo[400]),
                  ),
                  //border: InputBorder()
                ),
                onChanged: (value) {
                  adminEmailId = value;
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  hintText: "Admin Password",
                  //filled: true,
                  //fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.indigo[400], width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.indigo[400]),
                  ),
                  //border: InputBorder()
                ),
                onChanged: (value) {
                  adminPassword = value;
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminPanel()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                decoration: BoxDecoration(
                    color: Colors.indigo[400],
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "Admin LogIn",
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
      ),
    );
  }
}
