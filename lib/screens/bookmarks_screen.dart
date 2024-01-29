import 'package:alex_news_flutter/consts/vars.dart';
import 'package:alex_news_flutter/providers/bookmarks_provider.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:alex_news_flutter/widgets/articles_widget.dart';
import 'package:alex_news_flutter/widgets/drawer_widget.dart';
import 'package:alex_news_flutter/widgets/empty_news_widget.dart';
import 'package:alex_news_flutter/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/// 書籤頁
class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'BookMarks',
          style: GoogleFonts.lobster(
              textStyle:
                  TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: Provider.of<BookmarksProvider>(
              context,
              listen: false,
            ).fetchBookmarkNews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget(
                  newsType: NewsType.allNews,
                );
              } else if (snapshot.hasError) {
                return Expanded(
                  child: EmptyNewsWidget(
                    text: "an error occured ${snapshot.error}",
                    imagePage: 'assets/images/no_news.png',
                  ),
                );
              } else if (snapshot.data == null) {
                const EmptyNewsWidget(
                  text: 'You didn\'t add anything yet to your bookmarks',
                  imagePage: 'assets/images/bookmark.png',
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: snapshot.data![index],
                      child: const ArticleWidget(
                        isBookmark: true,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
