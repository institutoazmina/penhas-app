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
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.85);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Container(
        color: Color.fromRGBO(129, 129, 129, 0.11),
        child: Padding(
          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 20.0),
                child: Text(widget._group.header,
                    style: kTextStyleFeedTweetReplyHeader),
              ),
              SizedBox(
                height: 216.0,
                child: PageView.builder(
                    itemCount: widget._group.news.length,
                    controller: _pageController,
                    onPageChanged: (int page) =>
                        setState(() => _currentPage = page),
                    itemBuilder: (context, i) {
                      return Transform.scale(
                        scale: i == _currentPage ? 1 : 0.9,
                        child: _NewsItem(news: widget._group.news[i]),
                      );
                    }),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 22.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
              )
            ],
          ),
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
