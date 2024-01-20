import 'package:alex_news_flutter/consts/styles.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:alex_news_flutter/widgets/vetical_spacing.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

/// 新聞詳細頁
class NewsDetailsScreen extends StatefulWidget {
  static const routerName = "/NewsDetailsScreen";

  const NewsDetailsScreen({super.key});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'By Author',
          style: TextStyle(color: color),
        ),
        // leading: IconButton(
        //   icon: Icon(
        //     IconlyLight.arrowLeft2,
        //     color: color,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title" * 10,
                  textAlign: TextAlign.justify,
                  style: titleTextStyle,
                ),
                const VerticalSpacing(25),
                Row(
                  children: [
                    Text(
                      '20/20/2015',
                      style: smallTextStyle,
                    ),
                    const Spacer(),
                    Text(
                      'readingTimeText',
                      style: smallTextStyle,
                    )
                  ],
                ),
                const VerticalSpacing(25),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: FancyShimmerImage(
                      boxFit: BoxFit.fill,
                      errorWidget: Image.asset('assets/images/empty_image.png'),
                      imageUrl:
                          "https://storage.potatomedia.co/articles/potato_c53ddc30-1c40-4d42-8b4d-17b5eb1c9a7b_abcca2803988a8852dcb31510c6cb04d4df4fad6.png"),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Card(
                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              IconlyLight.send,
                              size: 28,
                              color: color,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              IconlyLight.bookmark,
                              size: 28,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const VerticalSpacing(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextContent(
                  label: 'Description',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const VerticalSpacing(10),
                TextContent(
                  label: 'description ' * 12,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                const VerticalSpacing(20),
                const TextContent(
                  label: 'Content ',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const VerticalSpacing(10),
                TextContent(
                  label: 'description ' * 12,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  const TextContent(
      {super.key,
      required this.label,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
