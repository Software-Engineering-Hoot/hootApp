import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/view/posts_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_infinite_list/posts/fragment/RFAccountFragment.dart';
import 'package:flutter_infinite_list/posts/fragment/HomeFragment.dart';
import 'package:flutter_infinite_list/posts/fragment/RFSearchFragment.dart';
import 'package:flutter_infinite_list/posts/fragment/RFSettingsFragment.dart';
import 'package:flutter_infinite_list/posts/utils/RFColors.dart';
import 'package:flutter_infinite_list/posts/utils/RFImages.dart';
import 'package:flutter_infinite_list/posts/widgets/RFWidget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  final _pages = [
    PostsPage(),
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
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 22),
          label: 'Home',
          activeIcon: Icon(Icons.home_outlined, color: colorPrimary, size: 22),
        ),
        BottomNavigationBarItem(
          icon: rf_search.iconImage(),
          label: 'Search',
          activeIcon: rf_search.iconImage(iconColor: colorPrimary),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
          activeIcon: Icon(
            Icons.add,
            color: colorPrimary,
            size: 22,
          ),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
          activeIcon: Icon(
            Icons.notifications,
            color: colorPrimary,
            size: 22,
          ),
        ),
        BottomNavigationBarItem(
          icon: rf_person.iconImage(),
          label: 'Account',
          activeIcon: rf_person.iconImage(iconColor: colorPrimary),
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

  Future<void> init() async {
    await setStatusBarColor(colorPrimary,
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
