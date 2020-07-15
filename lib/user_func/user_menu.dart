import 'package:country_dairy/user_func/bottom.dart';
import 'package:country_dairy/user_func/home.dart';
import 'package:country_dairy/user_func/user_home.dart';
import 'package:country_dairy/user_func/user_plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserMenu extends StatefulWidget {

  final ValueChanged<int> parentAction;
  UserMenu({Key key, this.parentAction}):super(key:key);
  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {


  Widget listItem(iconName, title, extra) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          //image: DecorationImage(image: WebsafeSvg.asset("assets/icon.svg")),
          //color: Colors.grey,
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            iconName,
            color: Colors.black,
          ),
          SizedBox(
            width: 26,
          ),
          //WebsafeSvg.asset("assets/icon.svg"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                extra,
                style: TextStyle(color: Colors.black),
              ),
              //Image.asset("")
            ],
          )
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 46,
                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Menu",
                      style: TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // implementation of on tap to go to page 0 of bottom navigation bar
                          widget.parentAction(0);
                        },
                        child: listItem(
                            Icons.calendar_today, "Calender", "Make changes"),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPlan(),
                                  maintainState: false));
                        },
                        child: listItem(Icons.dashboard, "My Plan",
                            "View modify current subscription"),
                      ),
                      Divider(),
                      listItem(Icons.shopping_basket, "Vacation",
                          "Pause, Resume And Vacation"),
                      Divider(),
                      listItem(Icons.account_balance_wallet, "Wallet",
                          "View Balance, Credit History and\nRecharge Wallet"),
                      Divider(),
                      listItem(Icons.supervised_user_circle, "My Profile",
                          "View, Update profile and Manage ring\nbell option"),
                      Divider(),
                      listItem(Icons.payment, "Bills", "View Monthly bills"),
                      Divider(),
                      listItem(Icons.local_offer, "Offers",
                          "View offers and Apply promo code"),
                      Divider(),
                      listItem(Icons.redeem, "Refer and Earn",
                          "View and share your referral"),
                      Divider(),
                      listItem(Icons.message, "Support",
                          "Help on queries Contact wiht our\nsupport team"),
                      Divider(),
                      listItem(Icons.save_alt, "Logout", ""),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
