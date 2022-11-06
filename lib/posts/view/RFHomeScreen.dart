import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_infinite_list/posts/fragment/RFAccountFragment.dart';
import 'package:flutter_infinite_list/posts/fragment/RFHomeFragment.dart';
import 'package:flutter_infinite_list/posts/fragment/RFSearchFragment.dart';
import 'package:flutter_infinite_list/posts/fragment/RFSettingsFragment.dart';
import 'package:flutter_infinite_list/posts/utils/RFColors.dart';
import 'package:flutter_infinite_list/posts/utils/RFImages.dart';
import 'package:flutter_infinite_list/posts/widgets/RFWidget.dart';

class RFHomeScreen extends StatefulWidget {
  @override
  _RFHomeScreenState createState() => _RFHomeScreenState();
}

class _RFHomeScreenState extends State<RFHomeScreen> {
  int _selectedIndex = 0;

  var _pages = [
    RFHomeFragment(),
    RFSearchFragment(),
    RFSettingsFragment(),
    RFAccountFragment(),
    RFAccountFragment(),
  ];

  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedLabelStyle: boldTextStyle(size: 14),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 22),
          label: 'Home',
          activeIcon:
              Icon(Icons.home_outlined, color: t1_colorPrimary, size: 22),
        ),
        BottomNavigationBarItem(
          icon: rf_search.iconImage(),
          label: 'Search',
          activeIcon: rf_search.iconImage(iconColor: t1_colorPrimary),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
          activeIcon: Icon(
            Icons.add,
            color: t1_colorPrimary,
            size: 22,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
          activeIcon: Icon(
            Icons.notifications,
            color: t1_colorPrimary,
            size: 22,
          ),
        ),
        BottomNavigationBarItem(
          icon: rf_person.iconImage(),
          label: 'Account',
          activeIcon: rf_person.iconImage(iconColor: t1_colorPrimary),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(t1_colorPrimary,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomTab(),
      body: Center(child: _pages.elementAt(_selectedIndex)),
    );
  }
}
