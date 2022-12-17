import 'package:flutter/material.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/images.dart';
import 'package:hoot/posts/view/add_advert.dart';
import 'package:hoot/posts/view/advert_page.dart';
import 'package:hoot/posts/view/profile.dart';
import 'package:hoot/posts/view/search.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  final _pages = [
    AdvertsPage(),
    Search(),
    AddAdvert(),
    Profile(),
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
          icon: Icon(Icons.home_outlined, size: 22),
          label: 'Home',
          activeIcon: Icon(Icons.home_outlined, color: colorPrimary, size: 22),
        ),
        BottomNavigationBarItem(
          icon: search.iconImage(),
          label: 'Search',
          activeIcon: search.iconImage(iconColor: colorPrimary),
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
          icon: person.iconImage(),
          label: 'Account',
          activeIcon: person.iconImage(iconColor: colorPrimary),
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
