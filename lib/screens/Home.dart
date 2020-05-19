import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

/**
 * Tabs imports
 */
import 'package:tvShowSubtitles/screens/tabs/HomeTab.dart';
import 'package:tvShowSubtitles/screens/tabs/LibraryTab.dart';
import 'package:tvShowSubtitles/screens/tabs/SettingsTab.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State{

  int selectedIndex = 0;
  PageController pageController;
  final bottomBarKey = GlobalKey();

  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child: PageView(
           controller: pageController,
           children: <Widget>[
             HomeTab(), LibraryTab(), SettingsTab()
           ],
         ),
       ),
       bottomNavigationBar: FancyBottomNavigation(
        // key: bottomBarKey,
         inactiveIconColor: Colors.redAccent,
        // barBackgroundColor: Colors.red,
         initialSelection: selectedIndex,
         tabs: [
           TabData(iconData: Icons.home, title: "Home"),
           TabData(iconData: Icons.library_books, title: "Library"),
           TabData(iconData: Icons.settings, title: "Settings")
         ],
         onTabChangedListener: (position){
           pageController.animateToPage(
               position,
               duration: Duration(milliseconds: 400),
               curve: Curves.easeIn
           );
         },
       ),
     );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}