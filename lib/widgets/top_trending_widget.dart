import 'package:alex_news_flutter/screens/blog_detail_screen.dart';
import 'package:alex_news_flutter/screens/news_detail_screen.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            /** 前往『 新聞詳細 』頁 **/
            Navigator.pushNamed(context, NewsDetailsScreen.routerName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset('assets/images/empty_image.png'),
                  imageUrl:
                      "https://storage.potatomedia.co/articles/potato_c53ddc30-1c40-4d42-8b4d-17b5eb1c9a7b_abcca2803988a8852dcb31510c6cb04d4df4fad6.png",
                  height: size.height * 0.33,
                  width: double.infinity,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                              child: const NewsDetailScreen(),
                              inheritTheme: true,
                              ctx: context),
                        );
                      },
                      icon: Icon(
                        Icons.link,
                        color: color,
                      )),
                  const Spacer(),
                  SelectableText(
                    '20-11-2024',
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
