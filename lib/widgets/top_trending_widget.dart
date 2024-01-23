import 'package:alex_news_flutter/models/news_model.dart';
import 'package:alex_news_flutter/screens/blog_detail_screen.dart';
import 'package:alex_news_flutter/screens/news_detail_screen.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            /** 前往『 新聞詳細 』頁 **/
            Navigator.pushNamed(
              context,
              NewsDetailsScreen.routerName,
              arguments: newsProvider.publishedAt,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset('assets/images/empty_image.png'),
                  imageUrl: newsProvider.urlToImage,
                  height: size.height * 0.33,
                  width: double.infinity,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    newsProvider.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        /** 開啟 『 新聞 WebView 』頁 **/
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: NewsDetailScreen(
                              url: newsProvider.url,
                            ),
                            inheritTheme: true,
                            ctx: context,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.link,
                        color: color,
                      )),
                  const Spacer(),
                  SelectableText(
                    newsProvider.dateToShow,
                    style: GoogleFonts.montserrat(fontSize: 15),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
