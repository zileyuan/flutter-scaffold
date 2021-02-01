import 'package:app/routers/app_router.dart';
import 'package:app/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  String url;
  String title;

  WebPage(this.url, this.title);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> with ScreenUtil {

  @override
  Widget build(BuildContext context) {
    String title = AppRouter.jsonUtf8Decode(widget.title);
    String url = AppRouter.jsonUtf8Decode(widget.url);
    return Scaffold(
      backgroundColor: Color(0xFFF6F7F9),
      appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.light,
            leading: IconButton(
              icon: Image.asset("assets/images/arrow-left.png",
                  width: setWidth(18),
                  height: setWidth(32),
                  fit: BoxFit.fill
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Container(
              width: setWidth(500),
              alignment: Alignment.center,
              child: Text(title,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: setSp(32),
                  fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            elevation: 0.8,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Color(0xFF7F7F7F), size: setWidth(18)),
          ),
          preferredSize: Size.fromHeight(setWidth(90))
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: Uri.encodeFull(url),
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
