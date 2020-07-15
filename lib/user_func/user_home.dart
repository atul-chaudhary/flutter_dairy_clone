import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  Widget listItemUser({color, mainHeading, extraText, icon_link}) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 0, 16),
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      width: 250,
      height: 180,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 38),
          Text(
            mainHeading,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            extraText,
            style: TextStyle(color: Colors.black87),
          ),
          SizedBox(
            height: 16,
          ),
          Image.asset(
            icon_link,
            width: 250,
            height: 140,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                decoration: BoxDecoration(color: Colors.white),
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/icon.png",
                      height: 46,
                      width: 46,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.account_balance_wallet,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "₹0.00",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 350,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    listItemUser(
                      icon_link: 'assets/icon1.jpg',
                      mainHeading: " Natural fresh\nfarm-to-home!",
                      color: Colors.lime[100],
                      extraText:
                          "bask in the goodness of essential nutrients and unadlurated milk",
                    ),
                    listItemUser(
                        icon_link: 'assets/icon2.jpg',
                        mainHeading: "Surety of Purity",
                        color: Colors.blue[100],
                        extraText: "Freshness and purity guaranteed everyday"),
                    listItemUser(
                        icon_link: 'assets/icon3.jpg',
                        mainHeading: "26 Tests Everyday",
                        color: Colors.brown[100],
                        extraText:
                            "Scientific quality testiong of milk for adultration at every stage"),
                    listItemUser(
                        icon_link: 'assets/icon4.jpg',
                        mainHeading: "Pasteurization and \n packing at 3C",
                        color: Colors.amber[100],
                        extraText:
                            "Maintaining milk at 3C imporves self life and prevents increase in bacteria counts"),
                    listItemUser(
                      icon_link: 'assets/icon5.jpg',
                      mainHeading: "Doorstep Delivery",
                      color: Colors.green[100],
                      extraText:
                          "Fresh Milk promises with added\n convience of home delivery\n everyday",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "No Orders Yet!",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Start Your SubsScription Now",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(26, 8, 26, 8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Text(
                  "Start My Plan",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
