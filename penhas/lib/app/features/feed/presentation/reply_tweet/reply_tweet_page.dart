import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/feed/presentation/reply_tweet/reply_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_avatar.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_body.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_title.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ReplyTweetPage extends StatefulWidget {
  final String title;
  const ReplyTweetPage({Key key, this.title = "ReplyTweet"}) : super(key: key);

  @override
  _ReplyTweetPageState createState() => _ReplyTweetPageState();
}

class _ReplyTweetPageState
    extends ModularState<ReplyTweetPage, ReplyTweetController>
    with SnackBarHandler {
  final String inputHint = 'Comente sua experiência sobre a postagem acima...';
  final String anonymousHint =
      'Sua publicação é anônima. As usuárias do app podem comentar sua publicação, mas só você pode iniciar uma conversa com elas.';
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  TextStyle get _kTextStyleNewTweetAnonymousHint => TextStyle(
      fontFamily: 'Lato',
      fontSize: 12.0,
      letterSpacing: 0.38,
      color: DesignSystemColors.warnGrey,
      fontWeight: FontWeight.normal);

  TextStyle get _kTextStyleNewTweetAnonymous => TextStyle(
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.44,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.bold);

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: SizedBox.expand(
        child: Container(
          color: Color.fromRGBO(248, 248, 248, 1.0),
          child: PageProgressIndicator(
            progressState: _currentState,
            child: GestureDetector(
              onTap: () => _handleTap(context),
              onPanDown: (_) => _handleTap(context),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TweetAvatar(
                              avatar: SvgPicture.network(
                                controller.tweet.avatar,
                                height: 36.0,
                                color: DesignSystemColors.darkIndigo,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                TweetTitle(
                                  tweet: controller.tweet,
                                  context: context,
                                  controller: null,
                                ),
                                TweetBody(content: controller.tweet.content),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('contribua comentando na postagem')),
                      ),
                      SizedBox(
                        height: 160,
                        child: TextField(
                          controller: controller.editingController,
                          maxLength: 2200,
                          maxLines: 15,
                          maxLengthEnforced: true,
                          onChanged: controller.setTweetContent,
                          decoration: InputDecoration(
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                  color: DesignSystemColors.ligthPurple),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                  color: DesignSystemColors.ligthPurple,
                                  width: 2.0),
                            ),
                            alignLabelWithHint: true,
                            hintText: inputHint,
                          ),
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            selectAll: true,
                            paste: true,
                          ),
                        ),
                      ),
                      Observer(builder: (context) {
                        return Visibility(
                            visible: controller.isAnonymousMode,
                            replacement: SizedBox(height: 20.0),
                            child: _buildAnonymousWarning());
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SizedBox(
                          height: 40,
                          width: 220,
                          child: Observer(builder: (_) {
                            return RaisedButton(
                              onPressed: controller.isEnableCreateButton
                                  ? () => controller.replyTweetPressed()
                                  : null,
                              elevation: 0.0,
                              shape: kButtonShapeFilled,
                              color: DesignSystemColors.ligthPurple,
                              child: Text(
                                'Publicar',
                                style: kTextStyleDefaultFilledButtonLabel,
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
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
      title: Text('Comentário'),
      backgroundColor: DesignSystemColors.ligthPurple,
    );
  }

  Padding _buildAnonymousWarning() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
          decoration: _buildInputTextBoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Text(
                  anonymousHint,
                  style: _kTextStyleNewTweetAnonymousHint,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/images/svg/drawer/user_profile.svg",
                        color: DesignSystemColors.darkIndigoThree,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          'Anônima',
                          style: _kTextStyleNewTweetAnonymous,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  BoxDecoration _buildInputTextBoxDecoration() {
    return BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8.0));
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
