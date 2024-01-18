import 'package:alex_news_flutter/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

/** 搜尋頁 **/
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchTextEditingController;
  late final FocusNode focusNode;

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
                        onEditingComplete: () {},
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
