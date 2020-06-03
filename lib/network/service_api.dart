import 'package:app/models/token_model.dart';
import 'package:app/utils/error_toast_util.dart';
import 'package:flutter/cupertino.dart';

import 'http_util.dart';

class ServiceApi {
  static final ServiceApi instance = ServiceApi._internal();

  factory ServiceApi() => instance;

  ServiceApi._internal() {
    httpUtil = HttpUtil();
  }

  HttpUtil httpUtil;

  Future<TokenModel> mobileLogin(
      BuildContext context, String mobile, String password) async {
    try {
      var params = {"mobile": mobile, "password": password};
      var baseResp = await httpUtil.request(context, "/account/mobileLogin",
          data: params, method: Method.POST);
      return TokenModel.fromJson(baseResp.data);
    } catch (e) {
      ErrorToastUtil.show(e, context);
    }
  }
}
