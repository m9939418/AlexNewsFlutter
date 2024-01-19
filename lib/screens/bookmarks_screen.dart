import 'package:alex_news_flutter/services/utils.dart';
import 'package:alex_news_flutter/widgets/empty_news_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: const EmptyNewsWidget(
        text: 'You didn\'t add anything yet to your bookmarks',
        imagePage: 'assets/images/bookmark.png',
      ),
      // ListView.builder(
      //     itemCount: 8,
      //     itemBuilder: (context, index) {
      //       return const ArticleWidget();
      //     }),
    );
  }
}
