import 'package:flutter/material.dart';
import 'package:app/utils/screen_util.dart';

class ConfirmDialog extends Dialog with ScreenUtil {
  final String text;
  final String cancelText;
  final String defineText;

  ConfirmDialog(
      {Key key,
        @required this.text,
        @required this.cancelText,
        @required this.defineText,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: setWidth(550),
          height: setWidth(280),
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius:
              BorderRadius.circular(setWidth(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                    left: setWidth(60),
                    top: setWidth(40),
                    right: setWidth(60),
                    bottom: setWidth(60)),
                child: Text(text,
//                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: setSp(30),
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: setWidth(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: setWidth(200),
                      height: setWidth(60),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFcccccc),
                              width: setWidth(1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              setWidth(8)))),
                      child: FlatButton(
                        padding: EdgeInsets.only(
                            left: setWidth(20),
                            right: setWidth(20)),
                        child: Text(
                          cancelText,
                          style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: setSp(26)),
                        ),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ),
                    Container(
                      width: setWidth(200),
                      height: setWidth(60),
                      decoration: BoxDecoration(
                        color: Color(0xFF036EB8),
                          border: Border.all(
                              color: Color(0xFF036EB8),
                              width: setWidth(1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              setWidth(8)))),
                      child: FlatButton(
                        padding: EdgeInsets.only(
                            left: setWidth(20),
                            right: setWidth(20)),
                        child: Text(
                          defineText,
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: setSp(26)),
                        ),
                        onPressed: () {
                          Navigator.pop(context, true);
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