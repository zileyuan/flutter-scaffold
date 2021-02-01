import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Page2Page extends StatefulWidget {
  @override
  _Page2PageState createState() => _Page2PageState();
}

class _Page2PageState extends State<Page2Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('page2.name'.tr()),
      ),
    );
  }
}
