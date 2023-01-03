import 'package:flutter/material.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/images.dart';
import 'package:hoot/posts/view/add_advert.dart';
import 'package:hoot/posts/view/home.dart';
import 'package:hoot/posts/view/notifications.dart';
import 'package:hoot/posts/view/profile.dart';
import 'package:hoot/posts/view/search.dart';
import 'package:hoot/posts/view/settings.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final _pages = [
    const Home(),
    const Search(),
    AddAdvert(),
    const Settings(),
    Profile(),
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
          icon: Icon(Icons.home_outlined, size: 17),
          label: 'Dashboard',
          activeIcon: Icon(Icons.home_outlined, color: colorPrimary, size: 22),
        ),
        BottomNavigationBarItem(
          icon: search.iconImage(),
          label: 'Search',
          activeIcon: search.iconImage(iconColor: colorPrimary, size: 22),
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            size: 17,
          ),
          label: 'Add',
          activeIcon: Icon(
            Icons.add,
            color: colorPrimary,
            size: 22,
          ),
        ),
        BottomNavigationBarItem(
          icon: setting.iconImage(),
          label: 'Settings',
          activeIcon: setting.iconImage(iconColor: colorPrimary, size: 22),
        ),
        BottomNavigationBarItem(
          icon: person.iconImage(),
          label: 'Account',
          activeIcon: person.iconImage(iconColor: colorPrimary, size: 22),
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
