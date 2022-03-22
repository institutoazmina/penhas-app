import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

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
                return Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 4.0,
                        )
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () async =>
                          _launchURL(widget.related.news[i].newsUri!),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            widget.related.news[i].title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: kTextStyleDrawerUsername,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              widget.related.news[i].source ?? '',
                              style: kTextStyleFeedTweetShowReply,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchURL(String uri) async {
    if (await canLaunch(uri)) {
      await launch(uri);
    }
  }
}
