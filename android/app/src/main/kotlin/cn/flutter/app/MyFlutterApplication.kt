package cn.flutter.app

import io.flutter.app.FlutterApplication
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid
import android.content.Context
import com.tencent.smtt.sdk.QbSdk
import android.util.Log

class MyFlutterApplication: FlutterApplication() {
    override fun onCreate() {
        super.onCreate();
        UmengAnalyticsPushFlutterAndroid.androidInit(this, "app_id", "default",
                false, "push_id")
        this.initX5(this.getApplicationContext());
    }

    fun initX5(context: Context?) {
        QbSdk.setDownloadWithoutWifi(true)
        val cb = object: QbSdk.PreInitCallback {
            override fun onViewInitFinished(arg0: Boolean) {
                //x5內核初始化完成的回调，为true表示x5内核加载成功，否则表示x5内核加载失败，会自动切换到系统内核。
                Log.d("app", " onViewInitFinished is " + arg0);
            }
            override fun onCoreInitFinished() {
                // TODO Auto-generated method stub
            }
        }
        //x5内核初始化接口
        QbSdk.initX5Environment(context, cb)
    }
}