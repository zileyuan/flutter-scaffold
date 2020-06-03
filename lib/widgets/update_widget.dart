import 'package:flutter/material.dart';
import 'dart:io';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:app/utils/screen_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/utils/toast_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app/utils/log_util.dart';

class UpdateWidget extends StatefulWidget {
  final String _updateURL;
  final List<String> _updataLog;
  final String version;
  final bool _force;

  UpdateWidget(
      String updateURL, List<String> updateLog, bool force, String version,
      {Key key})
      : this._updateURL = updateURL,
        this._updataLog = updateLog,
        this._force = force,
        this.version = version,
        super(key: key);

  @override
  _UpdateWidgetState createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> with ScreenUtil {
  int num = 1;
  ValueNotifier<double> vnPercent = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      RUpgrade.stream.listen((DownloadInfo info) {
        vnPercent.value = info.percent / 100;
      });
    }
  }

  requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      return true;
    } else {
      LogUtil.i("无外部存储写权限");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    int _last = 0;
    return WillPopScope(
        child: Align(
            child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                      // maxHeight: setH(650),
                      maxHeight: setHeight(590),
                      minHeight: setWidth(512),
                      maxWidth: setWidth(510)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(setWidth(24)))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/index_update_bg.png",
                            width: setWidth(510), fit: BoxFit.fitWidth),
                        Container(
                          margin: EdgeInsets.only(top: setWidth(20)),
                          width: setWidth(300),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/index_update_title_bg.png"),
                                  fit: BoxFit.fitHeight)),
                          child: Text('[${widget.version}] 发现新版本',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: setSp(33),
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                            child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              top: setWidth(32),
                              left: setWidth(56),
                              right: setWidth(56)),
                          children: widget._updataLog.map((value) {
                            return Text(value,
                                style: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: setSp(26),
                                    fontWeight: FontWeight.normal));
                          }).toList(),
                        )),
                        ValueListenableBuilder(
                            valueListenable: vnPercent,
                            builder: (context, value, child) {
                              return Container(
                                height: setWidth(24),
                                margin: EdgeInsets.only(top: setWidth(10)),
                                alignment: Alignment.centerLeft,
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: setWidth(32),
                                          right: setWidth(32)),
                                      height: setWidth(2),
                                      child: LinearProgressIndicator(
                                        value: vnPercent.value,
                                        backgroundColor: Color(0xFFE5E5E5),
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Color(0xFFFFBC4F)),
                                      ),
                                    ),
                                    Platform.isAndroid
                                        ? Container(
                                            height: setWidth(24),
                                            margin: EdgeInsets.only(
                                                left: setWidth(
                                                    (440 * vnPercent.value)
                                                            .toInt() +
                                                        20),
                                                right: setWidth(20)),
                                            child: Image.asset(
                                              "assets/images/index_progress_bg.png",
                                              width: setWidth(24),
                                              height: setWidth(24),
                                            ))
                                        : Container(),
                                  ],
                                ),
                              );
                            }),
                        Container(
                          width: double.infinity,
                          height: setWidth(50),
                          margin: EdgeInsets.only(
                              top: setWidth(34), bottom: setWidth(31)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: widget._force ? 0 : 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (num != 1) {
                                        ToastUtil.show('正在下载...');
                                      } else {
                                        Navigator.pop(context, false);
                                      }
                                    },
                                    child: Offstage(
                                      offstage: widget._force,
                                      child: Container(
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '下次提醒',
                                          style: TextStyle(
                                              color: Color(0xFF999999),
                                              fontSize: setSp(32)),
                                        ),
                                      ),
                                    ),
                                  )),
                              Offstage(
                                offstage: widget._force,
                                child: Container(
                                  width: setWidth(1),
                                  height: double.infinity,
                                  color: Colors.black12,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (num == 1) {
                                        if (Platform.isAndroid) {
                                          if (widget._updateURL
                                              .endsWith('apk')) {
                                            var reqPerm =
                                                await requestPermissions();
                                            if (reqPerm) {
                                              num++;
                                              int id = await RUpgrade.upgrade(
                                                  widget._updateURL,
                                                  apkName: 'mobile-ms.apk');
                                              num = 1;
                                              await RUpgrade.install(id);
                                            } else {
                                              ToastUtil.show('需授权访问存储，才可在线更新');
                                            }
                                          } else {
                                            launch(widget._updateURL);
                                          }
                                        } else if (Platform.isIOS) {
                                          launch(widget._updateURL);
                                        }
                                      } else {
                                        ToastUtil.show('正在下载...');
                                      }
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '马上升级',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).buttonColor,
                                            fontSize: setSp(32)),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ]),
                ))),
        onWillPop: () {
          int now = DateTime.now().millisecondsSinceEpoch;
          if (now - _last < 2000) {
            exit(0);
          } else {
            ToastUtil.show("再按一次退出", gravity: ToastGravity.BOTTOM);
            _last = DateTime.now().millisecondsSinceEpoch;
            return Future.value(false);
          }
          return Future.value(true);
        });
  }
}
