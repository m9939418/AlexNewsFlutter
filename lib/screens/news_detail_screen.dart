import 'dart:developer';

import 'package:alex_news_flutter/services/utils.dart';
import 'package:alex_news_flutter/widgets/vetical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final String url = "https://news.tvbs.com.tw/life/2305497";

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
                onPressed: () async {
                  await _showModalBottomSheet();
                },
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
                  initialUrl: url,
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

  Future<void> _showModalBottomSheet() async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            /** wrap_content **/
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalSpacing(20),
              Center(
                child: Container(
                  height: 5,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const VerticalSpacing(20),
              const Text(
                'More option',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              const VerticalSpacing(20),
              /** Share **/
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () async {
                  await Share.share(
                    'url',
                    subject: 'Look what I made!',
                  );
                },
              ),
              /** Open in browser **/
              ListTile(
                leading: const Icon(Icons.open_in_browser),
                title: const Text('Open in browser'),
                onTap: () async {
                  if (!await launchUrl(Uri.parse(url))) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
              /** Refresh **/
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text('Refresh'),
                onTap: () async {
                  try {
                    await _webViewController.reload();
                  } catch (err) {
                    log("error occured $err");
                  } finally {
                    if (context.mounted) Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
