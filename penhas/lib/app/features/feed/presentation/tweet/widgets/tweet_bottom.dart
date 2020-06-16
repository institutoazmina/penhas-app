import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class TweetBottom extends StatefulWidget {
  final TweetEntity tweet;
  final ITweetController controller;

  TweetBottom({
    Key key,
    @required this.tweet,
    @required this.controller,
  })  : assert(tweet != null),
        assert(controller != null),
        super(key: key);

  @override
  _TweetBottomState createState() => _TweetBottomState();
}

class _TweetBottomState extends State<TweetBottom> {
  bool _isLiked;
  int _likeCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.tweet.meta.liked;
    _likeCount = widget.tweet.totalLikes;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: _isLiked
                ? Icon(Icons.favorite,
                    size: 30.0, color: DesignSystemColors.pumpkinOrange)
                : Icon(Icons.favorite_border,
                    size: 30.0, color: DesignSystemColors.blueyGrey),
            onPressed: _toogleLike,
          ),
          Text('$_likeCount', style: kTextStyleFeedTweetTime),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(
              Icons.chat_bubble_outline,
              size: 30.0,
              color: DesignSystemColors.blueyGrey,
            ),
            onPressed: () => widget.controller.reply(widget.tweet),
          ),
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
}
