import 'package:alex_news_flutter/consts/vars.dart';
import 'package:alex_news_flutter/widgets/drawer_widget.dart';
import 'package:alex_news_flutter/widgets/tabs_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    });
                  },
                  fontSize: newsType == NewsType.topTrending ? 22 : 14,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
