package cn.flutter.app

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.content.Intent
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushPlugin

class MainActivity: FlutterActivity() {
    var handler: Handler = Handler(Looper.myLooper())

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    override fun onNewIntent(intent: Intent) {
        //每次重新到前台就主动更新intent并保存，之后就能获取到最新的intent
        setIntent(intent);
        super.onNewIntent(intent);
    }

    override fun onResume() {
        super.onResume()
        UmengAnalyticsPushFlutterAndroid.androidOnResume(this)
        if (getIntent().getExtras() != null) {
            var message = getIntent().getExtras().getString("message")
            if (message != null && message != "") {
                //启动界面要等待引擎加载，延迟5秒发送到界面
                handler.postDelayed(object : Runnable {
                    override fun run() {
                        UmengAnalyticsPushPlugin.eventSink.success(message)
                    }
                }, 5000)
            }
        }
    }

    override fun onPause() {
        super.onPause()
        UmengAnalyticsPushFlutterAndroid.androidOnPause(this)
    }
}
