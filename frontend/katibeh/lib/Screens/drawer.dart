import 'package:flutter/material.dart';
import 'package:katibeh/Screens/about_us.dart';
import 'package:katibeh/Screens/search.dart';
import 'package:katibeh/Screens/top_apps.dart';
import 'package:katibeh/Screens/top_free_apps.dart';

import 'categories.dart';
import 'home.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.lime,
                Colors.green,
              ]),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child:
                        Image.asset('images/logo.png', width: 80, height: 80),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'App Store',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomListTile(Icons.home, "Home", 18, () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(Home.id);
          }, false),
          Divider(),
          CustomListTile(Icons.search, "Search", 18, () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Search.id);
          }, false),
          Divider(),
          CustomListTile(Icons.apps, "Top Apps", 18,() {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(TopApps.id);
          }, false),
          Divider(),
          CustomListTile(Icons.money_off, "Top Free Apps", 18,() {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(TopFreeApps.id);
          }, false),
          Divider(),
          CustomListTile(Icons.category, "Categories", 18, () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(Categories.id);
          }, false),
          Divider(),
          CustomListTile(Icons.people, "About Us", 18, () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(AboutUs.id);
          }, false),
          Divider(),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final double size;
  final Function onTap;
  final bool arrow;

  CustomListTile(this.icon, this.text, this.size, this.onTap, this.arrow);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
//          decoration: BoxDecoration(
//              border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
          child: InkWell(
            splashColor: Color(0xff38dc05),
            onTap: () => onTap(),
            child: Container(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          icon,
                          color: Color(0xffd0a406),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text,
                          style: TextStyle(fontSize: size),
                        ),
                      ),
                    ],
                  ),
                  if (arrow) Icon(Icons.arrow_right)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
