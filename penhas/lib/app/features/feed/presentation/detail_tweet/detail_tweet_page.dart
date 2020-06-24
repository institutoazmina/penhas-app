import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_avatar.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_body.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_bottom.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_title.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'detail_tweet_controller.dart';

class DetailTweetPage extends StatefulWidget {
  final String title;
  final ITweetController tweetController;
  const DetailTweetPage({
    Key key,
    this.title = "DetailTweet",
    @required this.tweetController,
  }) : super(key: key);

  @override
  _DetailTweetPageState createState() => _DetailTweetPageState();
}

class _DetailTweetPageState
    extends ModularState<DetailTweetPage, DetailTweetController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showErrorMessage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _disposers.forEach((d) => d());
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tweet = controller.tweet;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: SizedBox.expand(
        child: Container(
          color: Color.fromRGBO(248, 248, 248, 1.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 6.0, right: 6.0, top: 8.0),
                    child: _MainTweet(
                      tweet: tweet,
                      controller: widget.tweetController,
                    ),
                  ),
                  Expanded(
                    child: Observer(builder: (_) {
                      return RefreshIndicator(
                        key: _refreshIndicatorKey,
                        onRefresh: _onRefresh,
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
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Detalhe'),
      backgroundColor: DesignSystemColors.ligthPurple,
    );
  }

  Future<void> _onRefresh() async {
    final bool isEndOfListView = _scrollController.position.extentAfter == 0;
    if (isEndOfListView) {
      return controller.fetchNextPage();
    }
  }

  Widget _buildTweetItem(TweetEntity tweet, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      child: _ReplyTweet(tweet: tweet, controller: widget.tweetController),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final bool isEndOfListView = _scrollController.position.extentAfter == 0;
    if (isEndOfListView) {
      _refreshIndicatorKey.currentState.show(atTop: false);
    }

    return isEndOfListView;
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }
}

class _MainTweet extends StatelessWidget {
  final TweetEntity tweet;
  final ITweetController controller;
  const _MainTweet({
    Key key,
    this.tweet,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 8.0, right: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TweetAvatar(
                    avatar: SvgPicture.network(
                      tweet.avatar,
                      color: DesignSystemColors.darkIndigo,
                      height: 36,
                    ),
                  ),
                  flex: 1,
                ),
                SizedBox(width: 6.0),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TweetTitle(
                          tweet: tweet,
                          context: context,
                          isDetail: true,
                          controller: controller),
                      TweetBody(content: tweet.content),
                      TweetBottom(tweet: tweet, controller: controller)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 8, bottom: 8),
            height: 28,
            child: Container(),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[350]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReplyTweet extends StatelessWidget {
  final TweetEntity tweet;
  final ITweetController controller;
  const _ReplyTweet({
    Key key,
    this.tweet,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TweetTitle(
                    tweet: tweet,
                    context: context,
                    isDetail: true,
                    controller: controller),
                TweetBody(content: tweet.content),
                TweetBottom(tweet: tweet, controller: controller)
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Container(),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[350]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
