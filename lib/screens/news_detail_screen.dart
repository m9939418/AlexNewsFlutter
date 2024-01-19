import 'package:alex_news_flutter/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 新聞 WebView 頁
class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late WebViewController _webViewController;
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return WillPopScope(
      onWillPop: () async {
        /** 處理 WebView 回上一頁 **/
        /** 如果 WebView可以回上一頁，則回上一頁 **/
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            /** 『 Back 』按鈕 **/
            leading: IconButton(
              icon: const Icon(IconlyLight.arrowLeft2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: IconThemeData(color: color),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            elevation: 0,
            title: Text(
              'URL',
              style: TextStyle(
                color: color,
              ),
            ),
            actions: [
              /** 『 更多 』按鈕 **/
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
          body: Column(
            children: [
              /** Loading Bar UI **/
              LinearProgressIndicator(
                value: _progress,
                color: _progress == 1 ? Colors.transparent : Colors.blue,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              Expanded(
                child: WebView(
                  initialUrl: 'https://news.tvbs.com.tw/life/2305497',
                  onProgress: (progress) {
                    _progress = progress / 100;
                  },
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
