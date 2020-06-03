package io.flutter.app

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    override fun onResume() {
        super.onResume()
        UmengAnalyticsPushFlutterAndroid.androidOnResume(this)
    }

    override fun onPause() {
        super.onPause()
        UmengAnalyticsPushFlutterAndroid.androidOnPause(this)
    }
}
