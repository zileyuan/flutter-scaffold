import 'dart:core';
import 'dart:io';

import 'package:app/stores/index_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/themes/dart_theme.dart';
import 'package:app/themes/light_theme.dart';
import 'package:provider/provider.dart';

import 'package:app/routers/app_router.dart';
import 'package:app/stores/user_notifier.dart';
import 'package:app/stores/ui_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: UINotifier()),
          ChangeNotifierProvider.value(value: UserNotifier()),
          ChangeNotifierProvider.value(value: IndexNotifier()),
        ],
        child: MyApp(),
      ),
    );
  });

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    Routes.configureRoutes();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UINotifier>(builder: (context, uiNotifier, child) {
      return MaterialApp(
        themeMode: UINotifier.themeMode,
        title: 'App',
        debugShowCheckedModeBanner: false,
        theme: LightTheme.get(),
        darkTheme: DarkTheme.get(),
        onGenerateRoute: AppRouter.router.generator,
      );
    });
  }
}
