import 'package:flutter/material.dart';

/** 搜尋頁 **/
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Search',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
