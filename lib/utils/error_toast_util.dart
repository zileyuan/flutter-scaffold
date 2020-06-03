import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/routers/app_router.dart';
import 'package:app/stores/user_notifier.dart';
import 'package:provider/provider.dart';

class ErrorToastUtil {
  static show(error, BuildContext context) {
    var e = error as DioError;
    if (e.response.statusCode == 403 || e.response.statusCode == 401) {
      Provider.of<UserNotifier>(context).changeUserModel(null);
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          AppRouter.navigateTo(context, Routes.loginPage, replace: true));
    }
  }
}
