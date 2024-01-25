import 'dart:convert';
import 'dart:developer';

import 'package:alex_news_flutter/consts/api_constant.dart';
import 'package:alex_news_flutter/consts/http_exceptions.dart';
import 'package:alex_news_flutter/models/bookmarks_model.dart';
import 'package:alex_news_flutter/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  static Future<List<NewsModel>> getAllNews(
      {required int page, required String sortBy}) async {
    // var url = Uri.parse(
    //     'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=2bd20a8e990348838b760332bbe293df');
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "20",
        "page": page.toString(),
        "sortBy": sortBy,
        // "apiKey": API_KEY,
      });
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['message']);
      }

      for (var v in data['articles']) {
        newsTempList.add(v);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  /// 『 TopHeadlines 』新聞API
  static Future<List<NewsModel>> getTopHeadlines() async {
    try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {
        "country": "us",
      });
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['message']);
      }

      for (var v in data['articles']) {
        newsTempList.add(v);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  /// 『 搜尋 』新聞API
  static Future<List<NewsModel>> searchNews({required String query}) async {
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": query,
        "pageSize": "20",
      });
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['message']);
      }

      for (var v in data['articles']) {
        newsTempList.add(v);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  /// 取得所有『 Bookmarks 』新聞 API
  static Future<List<BookmarksModel>?> getBookmarks() async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.get(uri);
      log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List allKeys = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (String key in data.keys) {
        allKeys.add(key);
      }
      log("allKeys $allKeys");
      return BookmarksModel.bookmarksFromSnapshot(json: data, allKeys: allKeys);
    } catch (e) {
      rethrow;
    }
  }
}
