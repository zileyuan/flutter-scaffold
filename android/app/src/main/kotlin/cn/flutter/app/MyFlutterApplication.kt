package cn.flutter.app

import io.flutter.app.FlutterApplication
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid

class MyFlutterApplication: FlutterApplication() {
    override fun onCreate() {
        super.onCreate();
        UmengAnalyticsPushFlutterAndroid.androidInit(this, "app_id", "default",
                false, "push_id")
    }
}