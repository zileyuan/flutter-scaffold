import 'dart:core';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:app/network/constans.dart';

class PrivatePage extends StatefulWidget {
  @override
  _PrivatePageState createState() => _PrivatePageState();
}

class _PrivatePageState extends State<PrivatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('隐私政策'),
      ),
      body: Center(
        child: WebView(
          initialUrl: Constants.privateUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
