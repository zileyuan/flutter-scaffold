import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/network/constans.dart';
import 'dart:convert';

import 'package:app/models/base_resp.dart';
import 'package:app/utils/log_util.dart';

/// 请求方法.
class Method {
  Method._();

  static const String GET = "GET";
  static const String POST = "POST";
  static const String PUT = "PUT";
  static const String HEAD = "HEAD";
  static const String DELETE = "DELETE";
  static const String PATCH = "PATCH";
}

class HttpUtil {
  String token;
  final bool isDebug = !bool.fromEnvironment("dart.vm.product");
  Dio _dio;
  String tokenMark = "Authorization";

  static final HttpUtil instance = HttpUtil._internal();
  factory HttpUtil() => instance;
  HttpUtil._internal() {
    initDio();
  }

  void initDio() {
    // 配置dio实例
    BaseOptions options = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        contentType: Headers.jsonContentType);
    _dio = new Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(onError: (DioError e) {
      if (e.response == null) e.response = Response();
      if (e.message.startsWith("SocketException")) {
        e.error = "网络连接异常，请检查您的网络状态";
      } else if (e.message.startsWith("Http status error [404]")) {
        e.error = "没有找到服务器";
      } else if (e.message.startsWith("Connecting timeout")) {
        e.error = "网络不稳定，请求超时";
      }
      return e; //continue
    }));

    //debug状态打印response
    if (isDebug) printLog();
  }

  Options getOptions(Options options) {
    if (options == null) {
      options = Options();
    }
    if (token != null) return options..headers = {tokenMark: token};
    return options;
  }

  Future<BaseResp<T>> request<T>(BuildContext context, String path,
      {String method: "POST",
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) async {
    Response response = await _dio.request(path,
        data: data,
        queryParameters: queryParameters,
        options: getOptions(options)..method = method,
        cancelToken: cancelToken);
    if (response.data is Map) {
      BaseResp<T> baseResp = BaseResp.fromJson(response.data);
      if (baseResp.code == '0') {
        return baseResp;
      }
      throw DioError(
          response: Response(statusCode: response.statusCode),
          error: baseResp.message,
          type: DioErrorType.RESPONSE);
    }
    throw DioError(
        response: Response(statusCode: -1),
        error: "错误",
        type: DioErrorType.RESPONSE);
  }

  printLog() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      LogUtil.i('================== 请求数据 ==========================\n'
          'url = ${options.uri.toString()}\n'
          'method = ${options.method}\n'
          'headers = ${options.headers}\n'
          'params = ${options.data}');
    }, onResponse: (Response response) {
      LogUtil.i('================== 响应数据 ==========================\n'
          'code = ${response.statusCode}\n'
          'data = ${json.encode(response.data)}');
    }, onError: (DioError e) {
      LogUtil.i('================== 错误响应数据 ======================\n'
          '${e.toString()}');
    }));
  }
}
