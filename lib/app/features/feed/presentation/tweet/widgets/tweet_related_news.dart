import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/text_styles.dart';
import '../../../../../shared/navigation/app_navigator.dart';
import '../../../domain/entities/tweet_entity.dart';

class TweetRelatedNews extends StatefulWidget {
  const TweetRelatedNews({
    super.key,
    required this.related,
  });

  final TweetRelatedNewsEntity related;

  @override
  State<TweetRelatedNews> createState() => _TweetRelatedNewsState();
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
  const _TweetRelatedNewsContent(this._entity);

  final TweetNewsEntity _entity;

  @override
  Widget build(BuildContext context) {
    const boxRadius = BorderRadius.all(Radius.circular(8.0));
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
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
                    maxLines: 2,
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
