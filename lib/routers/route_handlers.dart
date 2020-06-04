import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/index_page.dart';
import 'package:app/pages/splash_page.dart';
import 'package:app/pages/account/login_page.dart';
import 'package:app/pages/account/private_page.dart';

var splashPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        SplashPage());

var indexPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        IndexPage());

var loginPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        LoginPage());

var privatePageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        PrivatePage());
