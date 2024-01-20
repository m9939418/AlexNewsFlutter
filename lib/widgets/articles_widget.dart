import 'package:alex_news_flutter/consts/vars.dart';
import 'package:alex_news_flutter/screens/blog_detail_screen.dart';
import 'package:alex_news_flutter/screens/news_detail_screen.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

/**
 * 新聞列表item
 */
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key});

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
                          errorWidget: Image.asset('assets/images/empty_image.png'),
                          imageUrl:
                              "https://storage.potatomedia.co/articles/potato_c53ddc30-1c40-4d42-8b4d-17b5eb1c9a7b_abcca2803988a8852dcb31510c6cb04d4df4fad6.png"),
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
                          'title' * 100,
                          textAlign: TextAlign.justify,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: smallTextStyle,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '🕒 Reading time',
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
                                        child: const NewsDetailScreen(),
                                        inheritTheme: true,
                                        ctx: context),
                                  );
                                },
                                icon: const Icon(
                                  Icons.link,
                                  color: Colors.blue,
                                )),
                            Text(
                              '2024-22-22',
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
