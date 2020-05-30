import 'dart:async';

import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    navigate(context);
    return Scaffold(
      body: Center(
        child: Image.asset("images/logo.png")
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void  navigate(context){
    Timer t = Timer(Duration(milliseconds: 2000), () => Navigator.of(context).pushReplacementNamed('/home'));
  }
}