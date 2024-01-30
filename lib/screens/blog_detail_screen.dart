import 'package:alex_news_flutter/consts/styles.dart';
import 'package:alex_news_flutter/models/bookmarks_model.dart';
import 'package:alex_news_flutter/providers/bookmarks_provider.dart';
import 'package:alex_news_flutter/providers/news_provider.dart';
import 'package:alex_news_flutter/services/global_method.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:alex_news_flutter/widgets/vetical_spacing.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

/// 新聞詳細頁
class NewsDetailsScreen extends StatefulWidget {
  static const routerName = "/NewsDetailsScreen";

  const NewsDetailsScreen({super.key});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isInBookmark = false;
  String? publishedAt;
  dynamic currentBookmark;

  @override
  void didChangeDependencies() {
    publishedAt = ModalRoute.of(context)!.settings.arguments as String;
    final List<BookmarksModel> bookmarkList =
        Provider.of<BookmarksProvider>(context).getBookmarkList;
    if (bookmarkList.isEmpty) {
      return;
    }
    currentBookmark = bookmarkList
        .where((element) => element.publishedAt == publishedAt)
        .toList();
    if (currentBookmark.isEmpty) {
      isInBookmark = false;
    } else {
      isInBookmark = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    final bookMarksProvider = Provider.of<BookmarksProvider>(context);

    final currentNews = newsProvider.findByDate(publishedAt: publishedAt);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'By ${currentNews.authorName}',
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
                  currentNews.title,
                  textAlign: TextAlign.justify,
                  style: titleTextStyle,
                ),
                const VerticalSpacing(25),
                Row(
                  children: [
                    Text(
                      currentNews.dateToShow,
                      style: smallTextStyle,
                    ),
                    const Spacer(),
                    Text(
                      currentNews.readingTimeText,
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
                  child: Hero(
                    tag: currentNews.publishedAt,
                    child: FancyShimmerImage(
                      boxFit: BoxFit.fill,
                      errorWidget: Image.asset('assets/images/empty_image.png'),
                      imageUrl: currentNews.urlToImage,
                    ),
                  ),
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
                        GestureDetector(
                          onTap: () async {
                            try {
                              await Share.share(
                                currentNews.url,
                                subject: 'Look what I made!',
                              );
                            } catch (e) {
                              GlobalMethod.errorDialog(
                                errorMsg: e.toString(),
                                context: context,
                              );
                            }
                          },
                          child: Card(
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
                        ),
                        /** 『 加入書籤 』按鈕 **/
                        GestureDetector(
                          onTap: () async {
                            if (isInBookmark) {
                              await bookMarksProvider.deleteBookmarks(
                                key: currentBookmark[0].bookmarkKey,
                              );
                            } else {
                              await bookMarksProvider.addToBookmarks(
                                newsModel: currentNews,
                              );
                            }
                            await bookMarksProvider.fetchBookmarkNews();
                          },
                          child: Card(
                            elevation: 10,
                            shape: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isInBookmark
                                    ? IconlyBold.bookmark
                                    : IconlyLight.bookmark,
                                size: 28,
                                color: isInBookmark ? Colors.green : color,
                              ),
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
                  label: currentNews.description,
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
                  label: currentNews.content,
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
