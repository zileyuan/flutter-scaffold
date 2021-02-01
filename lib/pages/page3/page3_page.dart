import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Page3Page extends StatefulWidget {
  @override
  _Page3PageState createState() => _Page3PageState();
}

class _Page3PageState extends State<Page3Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('page3.name'.tr()),
      ),
    );
  }
}
