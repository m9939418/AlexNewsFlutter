import 'package:alex_news_flutter/models/news_model.dart';
import 'package:alex_news_flutter/services/news_api.dart';
import 'package:flutter/material.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

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
}
