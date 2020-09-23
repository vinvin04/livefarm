import 'package:flutter/material.dart';
import 'package:livefarm/External/fancy_bottom_navigation.dart';
import 'package:livefarm/pages/HomePage.dart';
import 'package:livefarm/pages/AddItem.dart';
import 'package:livefarm/pages/Settings.dart';

class Skeleton extends StatefulWidget {
  @override
  _SkeletonState createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  int _page = 0;

  List<Widget> _allPages = [
    HomePage(),
    AddItemPage(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: _allPages[_page],
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.home, title: "Home",),
            TabData(iconData: Icons.add_circle_outline, title: "Add"),
            TabData(iconData: Icons.settings, title: "Settings"),
          ],
          onTabChangedListener: (int index){
            setState(() {
              _page = index;
            });
          },
          barBackgroundColor: Theme.of(context).bottomAppBarColor,
          inactiveIconColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}