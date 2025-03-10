import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/design_system/colors.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../support_center/presentation/pages/support_center_general_error.dart';
import '../domain/entities/tweet_entity.dart';
import '../domain/states/feed_security_state.dart';
import 'feed_controller.dart';
import 'pages/feed_category_filter.dart';
import 'pages/feed_tags_filter.dart';
import 'stores/tweet_controller.dart';
import 'tweet/tweet.dart';
import 'tweet/widgets/tweet_group_news.dart';
import 'tweet/widgets/tweet_related_news.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({
    Key? key,
    this.title = 'Feed',
    required this.tweetController,
    required this.feedController,
  }) : super(key: key);

  final String title;
  final ITweetController tweetController;
  final FeedController feedController;

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with SnackBarHandler, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  FeedController get controller => widget.feedController;

  List<ReactionDisposer>? _disposers;

  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(
    debugLabel: 'feed-scaffold-key',
  );
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey(
    debugLabel: 'feed-refresh-indicator-key',
  );

  PageProgressState _currentState = PageProgressState.initial;

  bool _isFabCollapsed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    for (final d in _disposers!) {
      d();
    }
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: _bodyBuilder(),
      floatingActionButton: Observer(
        builder: (_) {
          if (!controller.isComposeTweetFabVisible) {
            return Container();
          }

          return _NewPostFab(isFabCollapsed: _isFabCollapsed);
        },
      ),
    );
  }

  Widget _bodyBuilder() {
    return Observer(
      builder: (_) {
        return PageProgressIndicator(
          progressState: _currentState,
          progressMessage: 'Aplicando os filtros',
          child: SizedBox.expand(
            child: Container(
              color: DesignSystemColors.systemBackgroundColor,
              child: SafeArea(
                child: controller.state.when(
                  initial: _buildInitialState,
                  loaded: _buildLoadedState,
                  error: _buildErrorState,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadedState(List<TweetTiles> items) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: _buildFiltersButton(controller.securityState),
        ),
        Expanded(
          child: _buildRefreshIndicator(items),
        ),
      ],
    );
  }

  RefreshIndicator _buildRefreshIndicator(List<TweetTiles> items) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      notificationPredicate: _handleScrollNotification,
      child: ListView.builder(
        itemCount: items.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return _buildTweetItem(items[index], context);
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
          bottom: 18.0,
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

    if (notification is UserScrollNotification &&
        notification.direction != ScrollDirection.idle) {
      final isScrollToBottom =
          notification.direction == ScrollDirection.reverse;
      if (isScrollToBottom != _isFabCollapsed) {
        setState(() {
          _isFabCollapsed = isScrollToBottom;
        });
      }
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

  Widget _buildErrorState(String message) {
    return SupportCenterGeneralError(
      message: message,
      onPressed: controller.fetchNextPage,
    );
  }
}

class _NewPostFab extends StatelessWidget {
  const _NewPostFab({
    Key? key,
    required bool isFabCollapsed,
  })  : _isFabCollapsed = isFabCollapsed,
        super(key: key);

  final bool _isFabCollapsed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Modular.to.pushNamed('/mainboard/compose');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: DesignSystemColors.ligthPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        minimumSize: const Size.square(56),
        fixedSize: const Size(double.infinity, 56),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/svg/bottom_bar/compose_tweet.svg',
            colorFilter: const ColorFilter.mode(
                DesignSystemColors.white, BlendMode.color),
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
          AnimatedContainer(
            constraints: BoxConstraints(
              maxWidth: _isFabCollapsed ? 0 : 100,
            ),
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Publicar',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: DesignSystemColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
