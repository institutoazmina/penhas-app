import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class TweetBottom extends StatefulWidget {
  const TweetBottom({
    Key? key,
    required this.tweet,
    required this.controller,
  }) : super(key: key);

  final TweetEntity tweet;
  final ITweetController controller;

  @override
  _TweetBottomState createState() => _TweetBottomState();
}

class _TweetBottomState extends State<TweetBottom> {
  late bool _isLiked;
  late int _likeCount;

  bool get _allowReply => widget.tweet.meta.canReply;
  bool get _isReplyVisible => _allowReply || widget.tweet.totalReply > 0;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.tweet.meta.liked;
    _likeCount = widget.tweet.totalLikes;
  }

  @override
  void didUpdateWidget(covariant TweetBottom oldWidget) {
    _isLiked = widget.tweet.meta.liked;
    _likeCount = widget.tweet.totalLikes;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: _isLiked
                ? const Icon(
                    Icons.favorite,
                    size: 30.0,
                    color: DesignSystemColors.pumpkinOrange,
                  )
                : const Icon(
                    Icons.favorite_border,
                    size: 30.0,
                    color: DesignSystemColors.blueyGrey,
                  ),
            onPressed: _toogleLike,
          ),
          Text('$_likeCount', style: kTextStyleFeedTweetTime),
          const SizedBox(width: 20),
          if (_isReplyVisible)
            IconButton(
              icon: const Icon(
                Icons.chat_bubble_outline,
                size: 30.0,
                color: DesignSystemColors.blueyGrey,
              ),
              onPressed: _allowReply ? _onReplyPressed : null,
            ),
          if (_isReplyVisible)
            Text('${widget.tweet.totalReply}', style: kTextStyleFeedTweetTime),
        ],
      ),
    );
  }

  void _toogleLike() {
    setState(() {
      _likeCount += _isLiked ? -1 : 1;
      _isLiked = !_isLiked;
    });

    widget.controller.like(widget.tweet);
  }

  void _onReplyPressed() {
    widget.controller.reply(widget.tweet);
  }
}
