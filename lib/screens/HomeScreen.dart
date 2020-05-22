import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

/**
 * Tabs imports
 */
import 'package:tvShowSubtitles/screens/tabs/HomeTab.dart';
import 'package:tvShowSubtitles/screens/tabs/LibraryTab.dart';
import 'package:tvShowSubtitles/screens/tabs/SettingsTab.dart';

Color backColor = Color.fromRGBO(255, 0, 0, 0.2);

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{

  int selectedIndex = 0;
  PageController pageController;
  final bottomBarKey = GlobalKey<CurvedNavigationBarState>();

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
           onPageChanged: (index){
             bottomBarKey.currentState.setPage(index);
           },
         ),
       ),
       bottomNavigationBar: CurvedNavigationBar(
         height: 55,
         key: bottomBarKey,
         backgroundColor: backColor,
         buttonBackgroundColor: Colors.white,
         color: Color.fromRGBO(250, 250, 250, 1),
         items: [
           Icon(Icons.home, size: 20),
           Icon(Icons.library_books, size: 20),
           Icon(Icons.settings, size: 20),
         ],
         onTap: (position){
           pageController.animateToPage(
               position,
               duration: Duration(milliseconds: 400),
               curve: Curves.easeIn
           );
         },
       ),
     );
  }

  /*Scaffold(
  bottomNavigationBar: CurvedNavigationBar(
  backgroundColor: Colors.blueAccent,
  items: <Widget>[
  Icon(Icons.add, size: 30),
  Icon(Icons.list, size: 30),
  Icon(Icons.compare_arrows, size: 30),
  ],
  onTap: (index) {
  //Handle button tap
  },
  ),
  body: Container(color: Colors.blueAccent),
  );*/
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}