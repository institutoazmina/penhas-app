import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../domain/entities/tweet_entity.dart';
import '../stores/tweet_controller.dart';
import '../tweet/widgets/tweet_body.dart';
import '../tweet/widgets/tweet_bottom.dart';
import '../tweet/widgets/tweet_title.dart';
import 'detail_tweet_controller.dart';

Color _defaultColor = Colors.white;
Color _highlightColor = DesignSystemColors.ligthPurple.withValues(alpha: 0.1);

class DetailTweetPage extends StatefulWidget {
  const DetailTweetPage({
    super.key,
    this.title = 'DetailTweet',
    required this.tweetController,
    required this.detailTweetController,
  });

  final String title;
  final ITweetController tweetController;
  final DetailTweetController detailTweetController;

  @override
  State<DetailTweetPage> createState() => _DetailTweetPageState();
}

class _DetailTweetPageState extends State<DetailTweetPage>
    with SnackBarHandler {
  DetailTweetController get _controller => widget.detailTweetController;
  List<ReactionDisposer>? _disposers;
  final _scrollController = AutoScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _refreshIndicatorKey.currentState?.show(atTop: false);
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
    for (final d in _disposers!) {
      d();
    }
    _scrollController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: SizedBox.expand(
        child: Container(
          color: DesignSystemColors.systemBackgroundColor,
          child: SafeArea(
            child: Observer(
              builder: (_) {
                _scrollToSelectedPosition();
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _onRefresh,
                  notificationPredicate: _handleScrollNotification,
                  child: _buildTweetListWithParentButton(),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Observer(builder: (_) => _buildReplyFab()),
    );
  }

  Widget _buildTweetListWithParentButton() {
    final String? parentId = _controller.tweet?.parentId;
    if (parentId == null || _controller.isWithoutGoToParentAction) {
      return _buildTweetList();
    }
    return Column(
      children: [
        _ShowParentTweetWidget(widget.tweetController, parentId),
        Flexible(child: _buildTweetList()),
      ],
    );
  }

  Widget _buildTweetList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      itemCount: _controller.listTweets.length,
      controller: _scrollController,
      itemBuilder: _buildTweetItem,
      separatorBuilder: (_, __) => SizedBox(
        height: 1,
        child: ColoredBox(color: Colors.grey[350]!),
      ),
    );
  }

  Widget _buildReplyFab() {
    if (!_controller.allowReply) return Container();
    return FloatingActionButton(
      heroTag: 'comment',
      backgroundColor: DesignSystemColors.ligthPurple,
      tooltip: 'Comentar',
      onPressed: _navigateToComment,
      child: const Icon(Icons.chat_bubble_outline),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Detalhe'),
      backgroundColor: DesignSystemColors.ligthPurple,
      foregroundColor: DesignSystemColors.white,
    );
  }

  Future<void> _onRefresh() async {
    final bool isEndOfListView = _scrollController.position.extentAfter == 0;
    if (isEndOfListView) {
      return _controller.fetchNextPage();
    }
  }

  Widget _buildTweetItem(BuildContext context, int index) {
    final TweetEntity tweet = _controller.listTweets[index];
    return AutoScrollTag(
      key: ValueKey(index),
      index: index,
      controller: _scrollController,
      child: _ReplyTweet(
        tweet: tweet,
        controller: widget.tweetController,
        isComment: index > 0,
        isHighlighted: index == _controller.selectedPosition,
        onHighlightFinish: _controller.highlightDone,
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final bool isEndOfListView = _scrollController.position.extentAfter == 0;
    final bool isRefreshVisible = isEndOfListView && !_controller.isFullyLoaded;

    if (isRefreshVisible) {
      _refreshIndicatorKey.currentState?.show(atTop: false);
    }

    return isRefreshVisible;
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => _controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  void _navigateToComment() {
    _controller.reply();
  }

  void _scrollToSelectedPosition() {
    if (_controller.selectedPosition != invalidPosition) {
      _scrollController.scrollToIndex(
        _controller.selectedPosition,
        duration: const Duration(milliseconds: 100),
      );
    }
  }
}

class _ReplyTweet extends StatefulWidget {
  const _ReplyTweet({
    required this.tweet,
    required this.controller,
    required this.isComment,
    required this.isHighlighted,
    required this.onHighlightFinish,
  });

  final TweetEntity tweet;
  final ITweetController controller;
  final bool isComment;
  final bool isHighlighted;
  final void Function() onHighlightFinish;

  @override
  State<StatefulWidget> createState() => _ReplyTweetState();
}

class _ReplyTweetState extends State<_ReplyTweet> {
  TweetEntity get _tweet => widget.tweet;
  ITweetController get controller => widget.controller;
  bool get _isComment => widget.isComment;
  Color _tweetBackground = _defaultColor;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _highlightIfNeeded();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isComment ? _onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: _tweetBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TweetTitle(
                tweet: _tweet,
                context: context,
                isDetail: true,
                controller: controller,
              ),
              TweetBody(
                content: _tweet.content,
                badges: _tweet.badges,
              ),
              TweetBottom(tweet: _tweet, controller: controller),
              if (_isComment && _tweet.totalReply > 0)
                _ShowReplyWidget(controller, _tweet),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    controller.detail(_tweet);
  }

  void _highlightIfNeeded() {
    if (!widget.isHighlighted) return;

    _timer ??= Timer.periodic(
      const Duration(milliseconds: 250),
      (timer) {
        setState(() {
          if (_tweetBackground == _highlightColor) {
            _tweetBackground = _defaultColor;
            if (timer.tick >= 2) {
              widget.onHighlightFinish();
              timer.cancel();
            }
          } else {
            _tweetBackground = _highlightColor;
          }
        });
      },
    );
  }
}

class _ShowReplyWidget extends StatelessWidget {
  const _ShowReplyWidget(this.controller, this.tweet);

  final ITweetController controller;
  final TweetEntity tweet;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () => controller.detail(tweet),
        child: Text(
          tweet.totalReply == 1 ? 'Ver resposta' : 'Ver todas as respostas',
          style: kTextStyleFeedTweetShowReply,
        ),
      );
}

class _ShowParentTweetWidget extends StatelessWidget {
  const _ShowParentTweetWidget(this.controller, this.tweetId);

  final ITweetController controller;
  final String tweetId;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () => controller.parent(tweetId),
        child: const Text(
          'Carregar publicação',
          style: kTextStyleFeedTweetShowReply,
        ),
      );
}
