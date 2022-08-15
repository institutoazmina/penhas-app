import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:penhas/app/shared/navigation/navigator.dart';

class TweetRelatedNews extends StatefulWidget {
  const TweetRelatedNews({
    Key? key,
    required this.related,
  }) : super(key: key);

  final TweetRelatedNewsEntity related;

  @override
  _TweetRelatedNewsState createState() => _TweetRelatedNewsState();
}

class _TweetRelatedNewsState extends State<TweetRelatedNews> {
  @override
  Widget build(BuildContext context) {
    final double viewPortScale = widget.related.news.length > 1 ? 0.80 : 0.95;

    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              'Conteúdo relacionado a',
              style: kTextStyleFeedTweetReplyHeader,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
            child: Text(
              '"${widget.related.header}"',
              style: kTextStyleDrawerUsername,
            ),
          ),
          SizedBox(
            height: 110,
            child: PageView.builder(
              itemCount: widget.related.news.length,
              controller: PageController(viewportFraction: viewPortScale),
              itemBuilder: (context, i) {
                return _TweetRelatedNewsContent(widget.related.news[i]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _TweetRelatedNewsContent extends StatelessWidget {
  const _TweetRelatedNewsContent(
    this._entity, {
    Key? key,
  }) : super(key: key);

  final TweetNewsEntity _entity;

  @override
  Widget build(BuildContext context) {
    const boxRadius = BorderRadius.all(Radius.circular(8.0));
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: boxRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0),
              blurRadius: 4.0,
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => AppNavigator.launchURL(_entity.newsUri),
            borderRadius: boxRadius,
            splashColor: DesignSystemColors.splashColor,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    _entity.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: kTextStyleDrawerUsername,
                  ),
                  if (_entity.source != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _entity.source!,
                        style: kTextStyleFeedTweetShowReply,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
