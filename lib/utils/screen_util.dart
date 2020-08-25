import 'package:flutter_screenutil/flutter_screenutil.dart' as util;
import 'package:flutter/material.dart';

mixin ScreenUtil {
  initScreenUtil(BuildContext context,
      {int width = 750, int height = 1334, bool allowFontScaling = false}) {
    util.ScreenUtil.init(context,
        width: width.toDouble(),
        height: height.toDouble(),
        allowFontScaling: allowFontScaling);
  }

  setHeight(int height) {
    return util.ScreenUtil().setHeight(height.toDouble());
  }

  setWidth(int width) {
    return util.ScreenUtil().setWidth(width.toDouble());
  }

  setSp(int fontSize) {
    return util.ScreenUtil().setSp(fontSize.toDouble());
  }

  ///当前设备高度 dp
  double get screenHeight => util.ScreenUtil.screenHeight;

  double get screenWidth => util.ScreenUtil.screenWidth;

  ///当前设备宽度 px
  double get screenWidthPx => util.ScreenUtil.screenWidthPx;

  ///当前设备高度 px
  double get screenHeightPx => util.ScreenUtil.screenHeightPx;

  ///状态栏高度 刘海屏会更高
  double get statusBarHeight => util.ScreenUtil.statusBarHeight;

  ///底部安全区距离
  double get bottomBarHeight => util.ScreenUtil.bottomBarHeight;

  ///实际的dp与设计稿px的比例
  get scaleWidth => util.ScreenUtil().scaleWidth;

  get scaleHeight => util.ScreenUtil().scaleHeight;
}
