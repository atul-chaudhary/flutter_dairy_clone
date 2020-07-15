import 'package:country_dairy/user_func/bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:country_dairy/user_func/user_home.dart';
import 'package:country_dairy/user_func/user_menu.dart';
import 'package:country_dairy/user_func/user_plan.dart';
import 'package:custom_navigator/custom_navigator.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  @override
  UserHomePageState createState() => UserHomePageState();
}

class UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  List<Widget> _children;
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    print(_currentIndex);
  }

  @override
  void initState() {
    // TODO: implement initState
    _children = [
      UserHome(),
      UserPlan(),
      UserMenu(
        parentAction: onTabTapped,
      ),
    ];

//    Future.delayed(Duration(seconds: 5),(){
//      onTabTapped(1);
//    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: (_currentIndex == 0) ? Colors.blue : Colors.grey,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                    color: (_currentIndex == 0) ? Colors.blue : Colors.grey),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                color: (_currentIndex == 1) ? Colors.blue : Colors.grey,
              ),
              title: Text(
                "MY Plan",
                style: TextStyle(
                    color: (_currentIndex == 1) ? Colors.blue : Colors.grey),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.filter_list,
                  color: (_currentIndex == 2) ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  "Menu",
                  style: TextStyle(
                      color: (_currentIndex == 2) ? Colors.blue : Colors.grey),
                )),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return SafeArea(
                top: false,
                bottom: false,
                child: CupertinoApp(
                  home: CupertinoPageScaffold(
                    resizeToAvoidBottomInset: false,
                    child: IndexedStack(
                      index: _currentIndex,
                      children: _children,
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
