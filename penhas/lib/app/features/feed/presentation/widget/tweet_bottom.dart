import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class TweetBottom extends StatefulWidget {
  final bool isLiked;
  final int likeCount;
  final int replyCount;
  final VoidCallback onLikePressed;
  final VoidCallback onReplyPressed;

  TweetBottom({
    Key key,
    @required this.isLiked,
    @required this.likeCount,
    @required this.replyCount,
    @required this.onLikePressed,
    @required this.onReplyPressed,
  })  : assert(isLiked != null),
        assert(likeCount != null),
        assert(replyCount != null),
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
    _isLiked = widget.isLiked;
    _likeCount = widget.likeCount;
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
            icon: Icon(Icons.chat_bubble_outline,
                size: 30.0, color: DesignSystemColors.blueyGrey),
            onPressed: widget.onReplyPressed,
          ),
          Text('${widget.replyCount}', style: kTextStyleFeedTweetTime),
        ],
      ),
    );
  }

  void _toogleLike() {
    setState(() {
      _likeCount += _isLiked ? -1 : 1;
      _isLiked = !_isLiked;
    });

    widget.onLikePressed();
  }
}
