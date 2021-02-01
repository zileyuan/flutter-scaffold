import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:app/routers/route_handlers.dart';
import 'package:app/routers/app_router.dart';
import 'package:app/utils/log_util.dart';

class Routes {
  Routes._internal();

  static String root = '/';
  static String indexPage = '/indexPage';
  static String loginPage = '/loginPage';

  static void configureRoutes() {
    final router = FluroRouter();
    AppRouter.router = router;

    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          LogUtil.i("RΩOUTE WAS NOT FOUND !!!");
          return;
        });

    router.define(root, handler: splashPageHandler);
    router.define(indexPage, handler: indexPageHandler);
    router.define(loginPage, handler: loginPageHandler);
  }
}
