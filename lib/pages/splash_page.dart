import 'package:flutter/material.dart';
import 'package:app/utils/screen_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:app/routers/app_router.dart';
import 'package:app/stores/user_notifier.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with ScreenUtil {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Rx.timer(0, Duration(milliseconds: 2000)).listen((_) {
        if (!UserNotifier.isLogin()) {
          AppRouter.navigateTo(context, Routes.indexPage, replace: true);
        } else {
          AppRouter.navigateTo(context, Routes.loginPage, replace: true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: setHeight(1000),
            ),
            Image.asset(
              'assets/images/logo.png',
              width: setWidth(130),
              height: setWidth(130),
            ),
            SizedBox(
              height: setHeight(20),
            ),
            Text('你，值得拥有！',
                style: TextStyle(
                  fontSize: setSp(28),
                )),
          ],
        ),
      ),
    );
  }
}
