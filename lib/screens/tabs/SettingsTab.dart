import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SettingsTabState();
}

class SettingsTabState extends State{
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}