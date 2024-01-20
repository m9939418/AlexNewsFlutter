import 'dart:convert';

import 'package:alex_news_flutter/consts/api_constant.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  static Future<void> getNews() async {
    // var url = Uri.parse(
    //     'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=2bd20a8e990348838b760332bbe293df');
    var uri = Uri.https(BASEURL, "v2/everything", {
      "q": "bitcoin",
      "pageSize": "5",
      // "apiKey": API_KEY,
    });
    var response = await http.get(
      uri,
      headers: {"X-Api-key": API_KEY},
    );
    Map data = jsonDecode(response.body);
    List newsTempList = [];
    for (var v in data['articles']) {
      newsTempList.add(v);
    }
    // return NewsModel.newsFromSnapshot(newsTempList);
  }
}
