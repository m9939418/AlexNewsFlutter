import 'dart:convert';
import 'dart:developer';

import 'package:alex_news_flutter/consts/api_constant.dart';
import 'package:alex_news_flutter/models/news_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BookmarksProvider with ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

  Future<void> addToBookmarks() async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.post(
        uri,
        body: json.encode({"Test": "Anything"}),
      );
      log('Response body: ${response.body}');
    } catch (e) {
      rethrow;
    }
  }
}
