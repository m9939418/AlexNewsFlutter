import 'package:alex_news_flutter/consts/vars.dart';
import 'package:alex_news_flutter/models/news_model.dart';
import 'package:alex_news_flutter/providers/news_provider.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:alex_news_flutter/widgets/articles_widget.dart';
import 'package:alex_news_flutter/widgets/empty_news_widget.dart';
import 'package:alex_news_flutter/widgets/vetical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

/// 搜尋頁
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchTextEditingController;
  late final FocusNode focusNode;

  List<NewsModel>? searchList = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchTextEditingController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          /** 取消焦點 **/
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    /** 『 Back 』按鈕 **/
                    GestureDetector(
                      child: const Icon(IconlyLight.arrowLeft2),
                      onTap: () {
                        focusNode.unfocus();
                        Navigator.pop(context);
                      },
                    ),
                    /** 搜尋欄位 **/
                    Flexible(
                      child: TextField(
                        controller: _searchTextEditingController,
                        focusNode: focusNode,
                        style: TextStyle(color: color),
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        onEditingComplete: () async {
                          searchList = await newsProvider.fetchSearchNews(
                              query: _searchTextEditingController.text);
                          focusNode.unfocus();
                          isSearching = true;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              bottom: 8 / 5,
                            ),
                            hintText: "Search",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            /** 『 清除 』按鈕 **/
                            suffix: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  _searchTextEditingController.clear();
                                  focusNode.unfocus();
                                  isSearching = false;
                                  searchList = [];
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpacing(10),
              if (!isSearching && searchList!.isEmpty)
                /** 搜尋關鍵字 **/
                Expanded(
                  child: MasonryGridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: searchKeywords.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          _searchTextEditingController.text =
                              searchKeywords[index];
                          searchList = await newsProvider.fetchSearchNews(
                              query: _searchTextEditingController.text);
                          focusNode.unfocus();
                          isSearching = true;
                          setState(() {});
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: color,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: FittedBox(
                              child: Text(
                                searchKeywords[index],
                              ),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              /** 查無新聞UI **/
              if (isSearching && searchList!.isEmpty)
                const Expanded(
                  child: EmptyNewsWidget(
                    text: "Ops! No data found",
                    imagePage: 'assets/images/search.png',
                  ),
                ),
              /** 如果有查詢到新聞 **/
              if (searchList != null && searchList!.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      itemCount: searchList!.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: searchList![index],
                            child: const ArticleWidget());
                      }),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (mounted) {
      _searchTextEditingController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }
}
