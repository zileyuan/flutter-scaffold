import 'package:flutter/material.dart';
import 'package:app/stores/ui_notifier.dart';
import 'package:app/utils/screen_util.dart';

class ConfirmDialog extends Dialog with ScreenUtil {
  final String text;
  final String cancelText;
  final String defineText;

  ConfirmDialog(
      {Key key,
        @required this.text,
        @required this.cancelText,
        @required this.defineText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: setWidth(500),
          height: setWidth(450),
          decoration: BoxDecoration(
              color: UINotifier.isDarkMode(context)? Colors.grey[800] : Color(0xFFFFFFFF),
              borderRadius:
              BorderRadius.circular(setWidth(24))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      left: setWidth(80),
                      top: setWidth(24),
                      right: setWidth(80)),
                  child: Image.asset(
                    "assets/images/index_you_no_see.png",
                    width: setWidth(135),
                    height: setWidth(135),
                  )),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                    left: setWidth(80),
                    top: setWidth(33),
                    right: setWidth(80),
                    bottom: setWidth(40)),
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
//                        color: Color(0xFF333333),
                        fontSize: setSp(32),
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                width: double.infinity,
                height: setWidth(68),
                margin:
                EdgeInsets.only(bottom: setWidth(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: setWidth(164),
                      height: setWidth(68),
                      decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(
                              setWidth(10)))),
                      child: FlatButton(
                        padding: EdgeInsets.only(
                            left: setWidth(20),
                            right: setWidth(20)),
                        child: Text(
                          defineText,
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: setSp(28)),
                        ),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ),
                    Container(
                      width: setWidth(164),
                      height: setWidth(68),
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(
                              color: Color(0xFF999999),
                              width: setWidth(1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              setWidth(10)))),
                      child: FlatButton(
                        padding: EdgeInsets.only(
                            left: setWidth(20),
                            right: setWidth(20)),
                        child: Text(
                          cancelText,
                          style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: setSp(28)),
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}