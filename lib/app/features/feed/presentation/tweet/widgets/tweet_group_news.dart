import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/text_styles.dart';
import '../../../../../shared/navigation/app_navigator.dart';
import '../../../domain/entities/tweet_entity.dart';

class TweetGroupNews extends StatefulWidget {
  const TweetGroupNews({Key? key, required TweetNewsGroupEntity group})
      : _group = group,
        super(key: key);

  final TweetNewsGroupEntity _group;

  @override
  _TweetGroupNewsState createState() => _TweetGroupNewsState();
}

class _TweetGroupNewsState extends State<TweetGroupNews> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final group = widget._group;
    final viewportFraction = widget._group.news.length > 1 ? 0.85 : 0.95;

    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Container(
        color: const Color.fromRGBO(129, 129, 129, 0.11),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (group.header.isNotEmpty) _buildHeader(group),
              SizedBox(
                height: 216.0,
                child: PageView.builder(
                  itemCount: group.news.length,
                  controller: PageController(
                    viewportFraction: viewportFraction,
                  ),
                  onPageChanged: (int page) =>
                      setState(() => _currentPage = page),
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 6,
                        left: 6,
                        bottom: 6,
                      ),
                      child: _NewsItem(news: group.news[i]),
                    );
                  },
                ),
              ),
              if (group.news.length > 1) _buildPaginationController(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildHeader(TweetNewsGroupEntity group) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 20.0),
      child: Text(group.header, style: kTextStyleFeedTweetReplyHeader),
    );
  }

  Widget _buildPaginationController() {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildPageIndicator(),
      ),
    );
  }

  List<Widget> _buildPageIndicator() => widget._group.news
      .mapIndexed((index, _) => _indicator(index == _currentPage))
      .toList();

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 24.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive
            ? DesignSystemColors.ligthPurple
            : DesignSystemColors.blueyGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class _NewsItem extends StatelessWidget {
  const _NewsItem({
    Key? key,
    required this.news,
  }) : super(key: key);

  final TweetNewsEntity news;

  @override
  Widget build(BuildContext context) {
    const boxRadius = BorderRadius.all(Radius.circular(8.0));
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: boxRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.network(
                  news.imageUri!,
                  height: 125,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(news.title, style: kTextStyleDrawerListItem),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          news.source ?? '',
                          style: kTextStyleFeedTweetShowReply,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        news.date!,
                        style: kTextStyleFeedTweetInput,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => AppNavigator.launchURL(news.newsUri),
                borderRadius: boxRadius,
                splashColor: DesignSystemColors.splashColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
