import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/models/update_model.dart';
import 'package:app/widgets/update_widget.dart';
import 'package:package_info/package_info.dart';
import 'package:dio/dio.dart';
import 'package:app/network/constans.dart';
import 'package:app/utils/log_util.dart';

class UpdateUtil {
  static Future<bool> tryUpdate(context) async {
    try {
      Response res = await Dio().get(Constants.updateUrl);
      if (res.statusCode == 200) {
        UpdateModel updateModel = UpdateModel.fromJson(res.data);
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        int buildNumber = int.parse(packageInfo.buildNumber);
        List<ReleaseModel> rels = updateModel.android;
        if (Platform.isIOS) {
          rels = updateModel.ios;
        }
        int maxBuild = buildNumber;
        bool force = false;
        ReleaseModel lastRelease;
        rels.forEach((release) {
          if (release.build > buildNumber) {
            force = force || release.force;
          }
          if (release.build > maxBuild) {
            maxBuild = release.build;
            lastRelease = release;
          }
        });
        LogUtil.i('====maxBuild: $maxBuild');
        LogUtil.i('====buildNumber: $buildNumber');
        if (maxBuild > buildNumber) {
          _upgrade(context, lastRelease.url, lastRelease.clog, force,
              lastRelease.version);
        }
        return maxBuild > buildNumber;
      }
    } catch (e) {
      LogUtil.i('Failed to get update info. Details: $e');
    }
    return false;
  }

  static Future _upgrade(context, url, clog, force, version) async {
    await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Color(0x3e000000),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) =>
            SlideTransition(
                //底部弹出动画
                position: Tween<Offset>(
                        begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                        parent: animation, curve: Curves.fastOutSlowIn)),
                child: UpdateWidget(url, clog, force, version)));
  }
}
