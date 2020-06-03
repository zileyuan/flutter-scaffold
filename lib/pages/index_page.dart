import 'package:flutter/material.dart';
import 'package:app/utils/iconfont_util.dart';
import 'package:app/utils/log_util.dart';
import 'package:app/utils/screen_util.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/account/accout_page.dart';
import 'package:app/pages/page2/page2_page.dart';
import 'package:app/pages/page3/page3_page.dart';
import 'package:app/utils/update_util.dart';
import 'package:provider/provider.dart';
import 'package:app/stores/index_notifier.dart';
import 'package:badges/badges.dart';
import 'package:app/widgets/confirm_dialog.dart';
import 'package:notification_permissions/notification_permissions.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with ScreenUtil {
  List<Widget> _pages;
  PageController _pageController;
  IndexNotifier _indexNotifier;
  ValueNotifier<bool> hasNewMessage = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pages = [HomePage(), Page2Page(), Page3Page(), AccountPage()];

    //界面初始化完成初始化用户信息和更新
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _indexNotifier = Provider.of<IndexNotifier>(context, listen: false)..addListener(indexListener);
      UpdateUtil.tryUpdate(context);
      checkNotificationPermStatus();
    });
  }

  List<BottomNavigationBarItem> _bottomTabs() {
    var tabs = List<BottomNavigationBarItem>()
      ..add(_buildBottomNavItem(Icon(IconfontUtil.icon_job, size: setSp(52),),
          Icon(IconfontUtil.icon_job, size: setSp(52), color: Colors
              .redAccent,),
          '首页', true))
      ..add(_buildBottomNavItem(Icon(IconfontUtil.icon_check, size: setSp(52),),
          Icon(IconfontUtil.icon_check, size: setSp(52), color: Colors
              .redAccent,),
          '页面2', true))
      ..add(_buildBottomNavItem(Icon(IconfontUtil.icon_msg, size: setSp(52),),
          Icon(IconfontUtil.icon_msg, size: setSp(52), color: Colors
              .redAccent,),
          '页面3', false))
      ..add(_buildBottomNavItem(Icon(IconfontUtil.icon_mine, size: setSp(52),),
          Icon(IconfontUtil.icon_mine, size: setSp(52), color: Colors
              .redAccent,),
          '我的', true));
    return tabs;
  }

  checkNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus().then((status) async {
      LogUtil.i('getNotificationPermissionStatus: $status');
      if (status != PermissionStatus.granted) {
        var result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialog(
                text: '通知权限没打开，将不能收到通知！',
                cancelText: '暂不打开',
                defineText: '立即设置',
              );
            });
        if (result) {
          NotificationPermissions.requestNotificationPermissions().then((st) {
            LogUtil.i('requestNotificationPermissions: $status');
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _indexNotifier?.removeListener(indexListener);
    _pageController?.dispose();
  }

  //监听
  indexListener() {
    var toIndex = IndexNotifier.currentIndex ?? 0;
    _pageController?.jumpToPage(toIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: doubleClickExit,
      child: Consumer<IndexNotifier>(
          child: PageView(
            physics: NeverScrollableScrollPhysics(), //禁止滚动
            controller: _pageController,
            children: _pages,
          ),
          builder: (context, indexProvide, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: SizedBox(
                child: BottomNavigationBar(
                  onTap: (index) {
                    indexProvide.changePage(index);
                  },
                  fixedColor: Theme.of(context).accentColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: IndexNotifier.currentIndex,
                  items: _bottomTabs(),
                ),
              ),
            );
          }),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      Icon icon, Icon activeIcon, String name, bool noBadge) {
    double height = setWidth(48), width = setWidth(48);
    return BottomNavigationBarItem(
        icon: ValueListenableBuilder(
          valueListenable: hasNewMessage,
          builder: (context, value, child) {
            return Badge(
              badgeContent: Text(
                'N',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: setSp(16),
                ),
              ),
              child: icon,
              showBadge: noBadge ? false : hasNewMessage.value,
              position: BadgePosition.topRight(
                  top: setWidth(-18), right: setWidth(-25)),
              padding: EdgeInsets.all(setWidth(8)),
            );
          },
        ),
        activeIcon: activeIcon,
        title: Text(
          name,
          style: TextStyle(fontSize: setSp(24)),
        ));
  }

  Future<bool> doubleClickExit() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            text: '您确定是要退出么',
            cancelText: '继续使用',
            defineText: '确定退出',
          );
        });
  }
}
