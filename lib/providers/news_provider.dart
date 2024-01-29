import 'package:alex_news_flutter/models/news_model.dart';
import 'package:alex_news_flutter/services/news_api.dart';
import 'package:flutter/material.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

  /// 取得『 一般 』新聞列表
  Future<List<NewsModel>> fetchAllNews({
    required int pageIndex,
    required String sortBy,
  }) async {
    newsList = await NewsApiService.getAllNews(
      page: pageIndex,
      sortBy: sortBy,
    );
    return newsList;
  }

  /// 取得『 TopHeadlines 』新聞列表
  Future<List<NewsModel>> fetchTopHeadlines() async {
    newsList = await NewsApiService.getTopHeadlines();
    return newsList;
  }

  /// 取得『 搜尋 』新聞列表
  Future<List<NewsModel>> fetchSearchNews({required String query}) async {
    newsList = await NewsApiService.searchNews(query: query);
    return newsList;
  }

  NewsModel findByDate({required String? publishedAt}) {
    return newsList
        .firstWhere((newsModel) => newsModel.publishedAt == publishedAt);
  }
}
