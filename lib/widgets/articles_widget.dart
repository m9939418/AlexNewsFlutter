import 'package:alex_news_flutter/consts/vars.dart';
import 'package:alex_news_flutter/screens/blog_detail_screen.dart';
import 'package:alex_news_flutter/screens/news_detail_screen.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

/// 新聞列表item
class ArticleWidget extends StatelessWidget {
  final String imageUrl, title, url, dateToShow, readingTime;

  const ArticleWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.url,
      required this.dateToShow,
      required this.readingTime});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            /** 前往『 新聞詳細 』頁 **/
            Navigator.pushNamed(context, NewsDetailsScreen.routerName);
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        height: size.height * 0.12,
                        width: size.height * 0.12,
                        boxFit: BoxFit.fill,
                        errorWidget:
                            Image.asset('assets/images/empty_image.png'),
                        imageUrl: imageUrl,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.justify,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: smallTextStyle,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '🕒 $readingTime',
                              style: smallTextStyle,
                            )),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  /** 開啟 『 新聞 WebView 』頁 **/
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: NewsDetailScreen(url: url,),
                                        inheritTheme: true,
                                        ctx: context),
                                  );
                                },
                                icon: const Icon(
                                  Icons.link,
                                  color: Colors.blue,
                                )),
                            Text(
                              dateToShow,
                              maxLines: 1,
                              style: smallTextStyle,
                            )
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
