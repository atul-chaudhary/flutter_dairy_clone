import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserVacations extends StatefulWidget {
  final CupertinoTabController tabController;

  UserVacations({this.tabController});

  @override
  _UserVacationsState createState() => _UserVacationsState();
}

Widget noVacation() {
  return Container(
    child: Column(
      children: <Widget>[
        Image.asset("assets/vaction_icon.jpg"),
        SizedBox(
          height: 46,
        ),
        Text("You have No Vacation added"),
        SizedBox(
          height: 46,
        ),
      ],
    ),
  );
}

class _UserVacationsState extends State<UserVacations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 46,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                Text("Vacations"),
                Icon(Icons.add),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
