import 'dart:convert';
import 'dart:developer';

import 'package:alex_news_flutter/consts/api_constant.dart';
import 'package:alex_news_flutter/models/bookmarks_model.dart';
import 'package:alex_news_flutter/models/news_model.dart';
import 'package:alex_news_flutter/services/news_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BookmarksProvider with ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

  List<BookmarksModel> bookmarkList = [];

  List<BookmarksModel> get getBookmarkList {
    return bookmarkList;
  }

  /// 『 新增 』Bookmark API
  Future<void> addToBookmarks({required NewsModel newsModel}) async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.post(
        uri,
        body: json.encode(newsModel.toJson()),
      );
      log('Response body: ${response.body}');
    } catch (e) {
      rethrow;
    }
  }

  /// 『 刪除 』Bookmark API
  Future<void> deleteBookmarks() async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.delete(
        uri,
      );
      log('Response body: ${response.body}');
    } catch (e) {
      rethrow;
    }
  }

  /// 取得所有『 Bookmarks 』新聞列表
  Future<List<BookmarksModel>> fetchBookmarkNews() async {
    bookmarkList = await NewsApiService.getBookmarks() ?? [];
    return bookmarkList;
  }
}
