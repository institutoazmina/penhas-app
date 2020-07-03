import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/tweet/tweet.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_group_news.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_related_news.dart';
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

class _FeedPageState extends ModularState<FeedPage, FeedController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;

  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  PageProgressState _currentState = PageProgressState.initial;

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
      _showProgress(),
      _showErrorMessage(),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: PageProgressIndicator(
        progressState: _currentState,
        progressMessage: 'Aplicando os filtros',
        child: SizedBox.expand(
          child: Container(
            color: Color.fromRGBO(248, 248, 248, 1.0),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
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
  }

  Future<void> _onRefresh() async {
    final bool isTopOfListView = _scrollController.position.pixels == 0;
    if (isTopOfListView) {
      return controller.fetchNextPage();
    }

    final bool isEndOfListView = _scrollController.position.extentAfter == 0;
    if (isEndOfListView) {
      return controller.fetchOldestPage();
    }
  }

  Widget _buildTweetItem(TweetTiles tweet, BuildContext context) {
    if (tweet is TweetEntity) {
      return Padding(
        padding: EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          bottom: 6.0,
          top: 6.0,
        ),
        child: Tweet(
          model: tweet,
          controller: widget.tweetController,
        ),
      );
    } else if (tweet is TweetRelatedNewsEntity) {
      return TweetRelatedNews(related: tweet);
    } else if (tweet is TweetNewsGroupEntity) {
      return TweetGroupNews(group: tweet);
    } else {
      return Container();
    }
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
            onPressed: () async {
              Modular.to.pushNamed('/mainboard/category').then((reloadFeed) {
                if (reloadFeed ?? false) {
                  controller.reloadFeed();
                }
              });
            },
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
            onPressed: () async {
              Modular.to.pushNamed('/mainboard/tags').then((reloadFeed) {
                if (reloadFeed ?? false) {
                  controller.reloadFeed();
                }
              });
            },
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

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.reloadState, (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }
}
