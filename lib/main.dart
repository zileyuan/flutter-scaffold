import 'dart:core';
import 'dart:io';

import 'package:app/stores/index_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:app/routers/app_router.dart';
import 'package:app/stores/user_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: UserNotifier()),
          ChangeNotifierProvider.value(value: IndexNotifier()),
        ],
        child: EasyLocalization(
            supportedLocales: [Locale('en'), Locale('zh')],
            path: 'assets/translations', // <-- change patch to your
            fallbackLocale: Locale('en'),
            child: MyApp()
        ),
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
    return MaterialApp(
      title: 'common.appName'.tr(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.router.generator,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
