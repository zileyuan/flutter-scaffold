import 'package:flutter/material.dart';
import 'package:app/utils/screen_util.dart';

class MessageDialog extends Dialog with ScreenUtil {
  final String title;
  final String btnText;
  final int height;

  MessageDialog(
      {Key key,
        @required this.title,
        @required this.btnText,
        @required this.height
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: setWidth(500),
          height: setWidth(height),
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(setWidth(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                    left: setWidth(40),
                    right: setWidth(40),
                    top: setWidth(40),
                    bottom: setWidth(60)),
                child: Text(title,
//                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: setSp(30),
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: setWidth(40)),
                decoration: BoxDecoration(
                    color: Color(0xFF036EB8),
                    borderRadius: BorderRadius.all(Radius.circular(
                        setWidth(8)))),
                child: SizedBox(
                  height: setWidth(60),
                  width: setWidth(220),
                  child: FlatButton(
                    padding: EdgeInsets.only(
                        left: setWidth(20),
                        right: setWidth(20)),
                    child: Text(
                      btnText,
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: setSp(28)),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}