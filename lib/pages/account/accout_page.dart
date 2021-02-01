import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('account.name'.tr()),
      ),
    );
  }
}
