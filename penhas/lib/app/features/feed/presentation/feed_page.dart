import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/widget/reply_tweet.dart';
import 'package:penhas/app/features/feed/presentation/widget/single_tweet.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'feed_controller.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key key, this.title = "Feed"}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.fetchNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: Color.fromRGBO(248, 248, 248, 1.0),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 19.0, bottom: 19.0),
                    child: _buildFiltersButton(),
                  ),
                  Expanded(
                    child: Observer(builder: (_) {
                      if (controller.currentState != PageProgressState.loaded) {
                        return _buildLoaderListItem();
                      } else {
                        return NotificationListener<ScrollNotification>(
                          onNotification: _handleScrollNotification,
                          child: ListView.builder(
                            itemCount: _calculateListItemCount(),
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return index >= controller.listTweets.length
                                  ? _buildLoaderListItem()
                                  : _buildTweetItem(
                                      controller.listTweets[index],
                                      context,
                                    );
                            },
                          ),
                        );
                        // return
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildTweetItem(TweetEntity tweet, BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 6.0, top: 6.0),
        child: tweet.lastReplay == null
            ? SingleTweet(tweet: tweet, rootContext: context)
            : ReplyTweet(tweet: tweet));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollNotification &&
        _scrollController.position.extentAfter == 0) {
      controller.fetchNextPage();
    }

    return false;
  }

  int _calculateListItemCount() {
    return controller.listTweets.length;
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
            onPressed: () {},
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
            onPressed: () {},
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

  Container _buildInputTweet() {
    return Container(
      height: 90.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 8.0,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          shape: BoxShape.rectangle,
          border: Border.all(color: Color.fromRGBO(216, 216, 216, 1.0)),
        ),
        child: Center(
          child: Text(
            'Gostaria de compartilhar alguma experiência ou história sua?',
            style: kTextStyleFeedTweetInput,
          ),
        ),
      ),
    );
  }

  void _onFabPressed(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        // return ComposeTootPage();
        // return Container(
        //   color: Colors.red,
        //   child: Column(
        //     children: <Widget>[
        //       ListTile(
        //         leading:
        //             SvgPicture.asset('assets/images/svg/bottom_bar/chat.svg'),
        //         title: Text('Conversar'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.block),
        //         title: Text('Bloquear'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.report),
        //         title: Text('Reportar'),
        //         onTap: () {},
        //       )
        //     ],
        //   ),
        // );
      },
    );
  }
}
