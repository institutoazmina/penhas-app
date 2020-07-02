import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class TweetGroupNews extends StatefulWidget {
  final TweetNewsGroupEntity _group;
  const TweetGroupNews({Key key, @required TweetNewsGroupEntity group})
      : _group = group,
        super(key: key);

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
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Container(
        color: Color.fromRGBO(129, 129, 129, 0.11),
        child: Padding(
          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              group.header.isEmpty ? Container() : _buildHeader(group),
              SizedBox(
                height: 216.0,
                child: PageView.builder(
                    itemCount: group.news.length,
                    controller: PageController(
                        initialPage: 0, viewportFraction: viewportFraction),
                    onPageChanged: (int page) =>
                        setState(() => _currentPage = page),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.only(right: 6.0, left: 6.0),
                        child: _NewsItem(news: group.news[i]),
                      );
                    }),
              ),
              group.news.length > 1
                  ? _buildPaginationController()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildHeader(TweetNewsGroupEntity group) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, bottom: 20.0),
      child: Text(group.header, style: kTextStyleFeedTweetReplyHeader),
    );
  }

  Container _buildPaginationController() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 22.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget._group.news.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }

    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 24.0 : 10.0,
      decoration: BoxDecoration(
          color: isActive
              ? DesignSystemColors.ligthPurple
              : DesignSystemColors.blueyGrey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}

class _NewsItem extends StatelessWidget {
  final TweetNewsEntity news;
  const _NewsItem({
    Key key,
    @required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launch(news.newsUri),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
              news.imageUri,
              height: 125,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(news.title, style: kTextStyleDrawerListItem),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      news.source ?? "",
                      style: kTextStyleFeedTweetShowReply,
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      news.date,
                      style: kTextStyleFeedTweetInput,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void launchURL(String uri) async {
    if (await canLaunch(uri)) {
      await launch(uri);
    }
  }
}
