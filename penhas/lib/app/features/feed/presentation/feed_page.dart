import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/states/feed_security_state.dart';
import 'package:penhas/app/features/feed/presentation/feed_controller.dart';
import 'package:penhas/app/features/feed/presentation/pages/feed_category_filter.dart';
import 'package:penhas/app/features/feed/presentation/pages/feed_tags_filter.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/tweet/tweet.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_group_news.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_related_news.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({
    Key? key,
    this.title = "Feed",
    required this.tweetController,
  }) : super(key: key);

  final String title;
  final ITweetController tweetController;

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;

  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  PageProgressState _currentState = PageProgressState.initial;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _refreshIndicatorKey.currentState?.show();
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
    _disposers!.forEach((d) => d());
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _bodyBuilder(),
    );
  }

  Observer _bodyBuilder() {
    return Observer(
      builder: (_) {
        return PageProgressIndicator(
          progressState: _currentState,
          progressMessage: 'Aplicando os filtros',
          child: SizedBox.expand(
            child: Container(
              color: DesignSystemColors.systemBackgroundColor,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: _buildFiltersButton(controller.securityState),
                    ),
                    Expanded(
                      child: _buildRefreshIndicator(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
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

  Widget _buildTweetItem(TweetTiles? tweet, BuildContext context) {
    if (tweet is TweetEntity) {
      return Padding(
        padding: const EdgeInsets.only(
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
      _refreshIndicatorKey.currentState?.show(atTop: false);
    }

    return true;
  }

  Widget _buildFiltersButton(FeedSecurityState securityState) {
    return securityState.when(
      enable: () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FeedCategoryFilter(reloadFeed: controller.reloadFeed),
          FeedTagsFilter(reloadFeed: controller.reloadFeed),
        ],
      ),
      disable: () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FeedTagsFilter(reloadFeed: controller.reloadFeed),
        ],
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String? message) {
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
