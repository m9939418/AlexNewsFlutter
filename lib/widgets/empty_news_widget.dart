import 'package:alex_news_flutter/services/utils.dart';
import 'package:flutter/material.dart';

/// 查無新聞 Widget
class EmptyNewsWidget extends StatelessWidget {
  final String text, imagePage;

  const EmptyNewsWidget(
      {super.key, required this.text, required this.imagePage});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(imagePage),
          ),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
