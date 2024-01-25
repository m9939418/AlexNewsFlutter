import 'package:alex_news_flutter/consts/vars.dart';
import 'package:alex_news_flutter/providers/bookmarks_provider.dart';
import 'package:alex_news_flutter/services/utils.dart';
import 'package:alex_news_flutter/widgets/vetical_spacing.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

/**
 * 新聞列表 loading item
 */
class LoadingWidget extends StatefulWidget {
  final NewsType newsType;

  const LoadingWidget({super.key, required this.newsType});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  BorderRadius borderRadius = BorderRadius.circular(18);
  late Color baseShimmerColor, highlightShimmerColor, widgetShimmerColor;

  @override
  void didChangeDependencies() {
    var utils = Utils(context);
    baseShimmerColor = utils.baseShimmerColor;
    highlightShimmerColor = utils.highlightShimmerColor;
    widgetShimmerColor = utils.widgetShimmerColor;
    Provider.of<BookmarksProvider>(
      context,
      listen: false,
    ).fetchBookmarkNews();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return widget.newsType == NewsType.topTrending
        /** Top trending Loading Widget **/
        ? Swiper(
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.9,
            itemCount: 5,
            itemBuilder: (context, index) {
              // return TopTrendingWidget();
              return TopTrendLoadingWidget(
                  baseShimmerColor: baseShimmerColor,
                  highlightShimmerColor: highlightShimmerColor,
                  size: size,
                  widgetShimmerColor: widgetShimmerColor,
                  borderRadius: borderRadius);
            },
          )
        /** All News Loading Widget **/
        : Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ArticlesShimmerEffectWidget(
                      baseShimmerColor: baseShimmerColor,
                      highlightShimmerColor: highlightShimmerColor,
                      widgetShimmerColor: widgetShimmerColor,
                      size: size,
                      borderRadius: borderRadius);
                }),
          );
  }
}

class TopTrendLoadingWidget extends StatelessWidget {
  const TopTrendLoadingWidget({
    super.key,
    required this.baseShimmerColor,
    required this.highlightShimmerColor,
    required this.size,
    required this.widgetShimmerColor,
    required this.borderRadius,
  });

  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Size size;
  final Color widgetShimmerColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Shimmer.fromColors(
          baseColor: baseShimmerColor,
          highlightColor: highlightShimmerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                /** Image **/
                child: Container(
                  height: size.height * 0.33,
                  width: double.infinity,
                  color: widgetShimmerColor,
                ),
              ),
              /** Title **/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: widgetShimmerColor,
                  ),
                ),
              ),
              /** Date **/
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: size.height * 0.025,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: widgetShimmerColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticlesShimmerEffectWidget extends StatelessWidget {
  const ArticlesShimmerEffectWidget({
    super.key,
    required this.baseShimmerColor,
    required this.highlightShimmerColor,
    required this.widgetShimmerColor,
    required this.size,
    required this.borderRadius,
  });

  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Color widgetShimmerColor;
  final Size size;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                child: Shimmer.fromColors(
                  baseColor: baseShimmerColor,
                  highlightColor: highlightShimmerColor,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: widgetShimmerColor,
                          height: size.height * 0.12,
                          width: size.height * 0.12,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.06,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                color: widgetShimmerColor),
                          ),
                          const VerticalSpacing(2),
                          Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: size.height * 0.025,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: borderRadius,
                                    color: widgetShimmerColor),
                              )),
                          FittedBox(
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    color: widgetShimmerColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: size.height * 0.025,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                      borderRadius: borderRadius,
                                      color: widgetShimmerColor),
                                )
                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
