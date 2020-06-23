import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/tweet/tweet.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'feed_controller.dart';

class FeedPage extends StatefulWidget {
  final String title;
  final ITweetController tweetController;
  const FeedPage({
    Key key,
    this.title = "Feed",
    @required this.tweetController,
  }) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  final _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: Color.fromRGBO(248, 248, 248, 1.0),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 19.0, bottom: 19.0),
                    child: _buildFiltersButton(),
                  ),
                  Expanded(
                    child: _buildFeedObserver(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Observer _buildFeedObserver() {
    return Observer(
      builder: (_) {
        return _buildRefreshIndicator();
      },
    );
  }

  RefreshIndicator _buildRefreshIndicator() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: onRefresh,
      notificationPredicate: _handleScrollNotification,
      child: ListView.builder(
        itemCount: controller.listTweets.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return _buildTweetItem(
            controller.listTweets[index],
            context,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> onRefresh() async {
    final bool isTopOfListView = _scrollController.position.pixels == 0;
    if (isTopOfListView) {
      return controller.fetchNextPage();
    }

    final bool isEndOfListView = _scrollController.position.extentAfter == 0;
    if (isEndOfListView) {
      return controller.fetchOldestPage();
    }
  }

  Widget _buildTweetItem(TweetEntity tweet, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.0, top: 6.0),
      child: Tweet(
        model: tweet,
        controller: widget.tweetController,
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final bool isEndOfListView = _scrollController.position.extentAfter == 0;
    if (isEndOfListView) {
      _refreshIndicatorKey.currentState.show(atTop: false);
    }

    return true;
  }

  Row _buildFiltersButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 32.0,
          width: 140.0,
          child: RaisedButton(
            elevation: 0.0,
            onPressed: () {},
            color: DesignSystemColors.white,
            shape: kButtonShapeOutlinePurple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Categorias', style: kTextStyleFeedCategoryButtonLabel),
                Icon(
                  Icons.arrow_drop_down,
                  color: DesignSystemColors.ligthPurple,
                  size: 32.0,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 32.0,
          width: 160.0,
          child: RaisedButton(
            elevation: 0.0,
            onPressed: () {},
            color: DesignSystemColors.white,
            shape: kButtonShapeOutlinePurple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.filter_list,
                  color: DesignSystemColors.ligthPurple,
                  size: 22.0,
                ),
                Text('Filtros por temas',
                    style: kTextStyleFeedCategoryButtonLabel),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
