import 'package:alex_news_flutter/consts/vars.dart';
import 'package:alex_news_flutter/models/news_model.dart';
import 'package:alex_news_flutter/providers/news_provider.dart';
import 'package:alex_news_flutter/screens/search_screen.dart';
import 'package:alex_news_flutter/services/news_api.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:alex_news_flutter/widgets/articles_widget.dart';
import 'package:alex_news_flutter/widgets/drawer_widget.dart';
import 'package:alex_news_flutter/widgets/empty_news_widget.dart';
import 'package:alex_news_flutter/widgets/loading_widget.dart';
import 'package:alex_news_flutter/widgets/tabs_widget.dart';
import 'package:alex_news_flutter/widgets/top_trending_widget.dart';
import 'package:alex_news_flutter/widgets/vetical_spacing.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.popularity.name;

  /// 取得所有新聞
  // Future<List<NewsModel>> fetchAllNews() async {
  //   List<NewsModel> newsList = await NewsApiService.getAllNews();
  //   return newsList;
  // }

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'News app',
            style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
          actions: [
            /** 『 搜尋 』按鈕 **/
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: SearchScreen(),
                        inheritTheme: true,
                        ctx: context),
                  );
                },
                icon: const Icon(IconlyLight.search))
          ],
        ),
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  /** All News **/
                  TabsWidget(
                    text: 'All news',
                    color: newsType == NewsType.allNews
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    function: () {
                      if (newsType == NewsType.allNews) {
                        return;
                      }
                      setState(() {
                        newsType = NewsType.allNews;
                        print(newsType.name);
                      });
                    },
                    fontSize: newsType == NewsType.allNews ? 22 : 14,
                  ),
                  const SizedBox(width: 25),
                  /** Top trending News **/
                  TabsWidget(
                    text: 'Top trending',
                    color: newsType == NewsType.topTrending
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    function: () {
                      if (newsType == NewsType.topTrending) {
                        return;
                      }
                      setState(() {
                        newsType = NewsType.topTrending;
                        print(newsType.name);
                      });
                    },
                    fontSize: newsType == NewsType.topTrending ? 22 : 14,
                  ),
                ],
              ),
            ),
            newsType == NewsType.topTrending
                ? Container()
                : SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        paginationButton(
                            function: () {
                              setState(() {
                                if (currentPageIndex == 0) return;
                                currentPageIndex -= 1;
                              });
                            },
                            text: 'prev'),
                        Flexible(
                          flex: 2,
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: currentPageIndex == index
                                        ? Colors.blue
                                        : Theme.of(context).cardColor,
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentPageIndex = index;
                                          });
                                        },
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${index + 1}"),
                                        ))),
                                  ),
                                );
                              }),
                        ),
                        paginationButton(
                            function: () {
                              setState(() {
                                if (currentPageIndex == 4) return;
                                currentPageIndex += 1;
                              });
                            },
                            text: 'next'),
                      ],
                    ),
                  ),
            const VerticalSpacing(10),
            newsType == NewsType.topTrending
                ? Container()
                : Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                            value: sortBy,
                            items: dropDownItem,
                            onChanged: (String? value) {}),
                      ),
                    ),
                  ),
            FutureBuilder(
              future:
                  newsProvider.fetchAllNews(pageIndex: currentPageIndex + 1),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return newsType == NewsType.allNews
                      ? LoadingWidget(
                          newsType: newsType,
                        )
                      : Expanded(
                          child: LoadingWidget(
                            newsType: newsType,
                          ),
                        );
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: EmptyNewsWidget(
                      text: "an error occured ${snapshot.error}",
                      imagePage: 'assets/images/no_news.png',
                    ),
                  );
                } else if (snapshot.data == null) {
                  return const EmptyNewsWidget(
                    text: "no news found",
                    imagePage: 'assets/images/no_news.png',
                  );
                }
                return newsType == NewsType.allNews
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider.value(
                                  value: snapshot.data![index],
                                  child: const ArticleWidget());
                              // return ArticleWidget(
                              //   imageUrl: snapshot.data![index].urlToImage,
                              //   dateToShow: snapshot.data![index].dateToShow,
                              //   readingTime:
                              //       snapshot.data![index].readingTimeText,
                              //   title: snapshot.data![index].title,
                              //   url: snapshot.data![index].url,
                              // );
                            }),
                      )
                    : SizedBox(
                        height: size.height * 0.6,
                        child: Swiper(
                          // autoplay: true,
                          // autoplayDelay: 2000,
                          // itemWidth: size.width * 0.9,
                          // layout: SwiperLayout.STACK,
                          viewportFraction: 0.9,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return TopTrendingWidget(
                              url: snapshot.data![index].url,
                            );
                          },
                        ),
                      );
              },
            ),
            // LoadingWidget(newsType: newsType,),
          ],
        ),
      ),
    );
  }

  /** 設定 DropdownMenuItems **/
  List<DropdownMenuItem<String>> get dropDownItem {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text(SortByEnum.relevancy.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text(SortByEnum.publishedAt.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(SortByEnum.popularity.name),
      ),
    ];
    return menuItem;
  }

  Widget paginationButton({required Function function, required String text}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: const EdgeInsets.all(6),
          textStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
