import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('account.login.name'.tr()),
      ),
    );
  }
}
