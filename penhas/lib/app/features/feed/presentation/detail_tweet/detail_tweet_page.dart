import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/tweet/single_tweet.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_avatar.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_body.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_bottom.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_title.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

import 'detail_tweet_controller.dart';

class DetailTweetPage extends StatefulWidget {
  final String title;
  final ITweetController tweetController;
  const DetailTweetPage({
    Key key,
    this.title = "DetailTweet",
    @required this.tweetController,
  }) : super(key: key);

  @override
  _DetailTweetPageState createState() => _DetailTweetPageState();
}

class _DetailTweetPageState
    extends ModularState<DetailTweetPage, DetailTweetController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  PageProgressState _currentState = PageProgressState.initial;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showErrorMessage(),
      _showProgress(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _disposers.forEach((d) => d());
  }

  @override
  Widget build(BuildContext context) {
    final tweet = controller.tweet;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: SizedBox.expand(
        child: Container(
          color: Color.fromRGBO(248, 248, 248, 1.0),
          child: PageProgressIndicator(
            progressState: _currentState,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: TweetAvatar(
                            avatar: SvgPicture.network(
                              tweet.avatar,
                              color: DesignSystemColors.darkIndigo,
                              height: 36,
                            ),
                          ),
                          flex: 1,
                        ),
                        SizedBox(width: 6.0),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TweetTitle(
                                tweet: tweet,
                                context: context,
                                isDetail: true,
                                controller: widget.tweetController,
                              ),
                              TweetBody(content: tweet.content),
                              TweetBottom(
                                  tweet: tweet,
                                  controller: widget.tweetController)
                            ],
                          ),
                        )
                      ],
                    ),
                    // SingleTweet(
                    //   tweet: controller.tweet,
                    //   context: context,
                    //   controller: widget.tweetController,
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Detalhe'),
      backgroundColor: DesignSystemColors.ligthPurple,
    );
  }

  _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.currentState, (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }
}
