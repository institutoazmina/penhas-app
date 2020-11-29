import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetTitle extends StatelessWidget {
  final TweetEntity tweet;
  final BuildContext _context;
  final ITweetController controller;
  final bool isDetail;

  const TweetTitle({
    Key key,
    @required this.tweet,
    @required BuildContext context,
    @required this.controller,
    this.isDetail = false,
  })  : assert(tweet != null),
        _context = context,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return tweet.anonymous
        ? _showAnonymousHeader()
        : _showAuthenticatedHeader();
  }

  Widget _buildTime() {
    timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
    final parsedTime = _mapServerUtcToLocalDate(tweet.createdAt);
    return Text(timeago.format(parsedTime, locale: 'pt_br'),
        style: kTextStyleFeedTweetTime);
  }

  Widget _buildDetailTime() {
    final parsedTime = _mapServerUtcToLocalDate(tweet.createdAt);
    final hour = _stringfyFormatted(parsedTime.hour);
    final minute = _stringfyFormatted(parsedTime.minute);
    final day = _stringfyFormatted(parsedTime.day);
    final month = _stringfyFormatted(parsedTime.month);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        "$day/$month/${parsedTime.year} · $hour:$minute",
        style: kTextStyleFeedTweetTime,
      ),
    );
  }

  String _stringfyFormatted(int value) {
    return value > 9 ? "$value" : "0$value";
  }

  DateTime _mapServerUtcToLocalDate(String time) {
    final utcEnabled = "${time}Z";

    return DateTime.parse(utcEnabled).toLocal();
  }

  double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  void _showTweetAction() async {
    await showModalBottomSheet(
      context: _context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 5, bottom: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 150,
          child: Column(
            children: <Widget>[_buildDivider(context), ..._buildAction()],
          ),
        );
      },
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      width: fullWidth(context) * .2,
      height: 5,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  List<Widget> _buildAction() {
    List<Widget> actions = List<Widget>();
    if (!tweet.anonymous) {
      actions.add(
        ListTile(
          leading: SvgPicture.asset(
              'assets/images/svg/tweet_action/tweet_action_chat.svg'),
          title: Text('Conversar'),
          onTap: () {},
        ),
      );
    }

    if (!tweet.meta.owner) {
      actions.add(
        ListTile(
          leading: SvgPicture.asset(
              'assets/images/svg/tweet_action/tweet_action_report.svg'),
          title: Text('Denunciar'),
          onTap: () {
            Navigator.of(_context).pop();
            controller.report(tweet);
          },
        ),
      );
    }

    if (tweet.meta.owner) {
      actions.insert(
        0,
        ListTile(
          leading: SvgPicture.asset(
              'assets/images/svg/tweet_action/tweet_action_delete.svg'),
          title: Text('Apagar'),
          onTap: () {
            controller
                .delete(tweet)
                .whenComplete(() => Navigator.of(_context).pop());
          },
        ),
      );
    }

    return actions;
  }

  Widget _showAnonymousHeader() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(tweet.userName, style: kTextStyleFeedTweetTitle),
            flex: 2),
        isDetail ? _buildDetailTime() : _buildTime(),
        controller == null
            ? Container()
            : IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => _showTweetAction()),
      ],
    );
  }

  Widget _showAuthenticatedHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            child: _buttonTitle(),
            onPressed: () => _showUserProfile(),
            color: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: EdgeInsets.zero,
          ),
        ),
        controller == null
            ? Container()
            : IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => _showTweetAction()),
      ],
    );
  }

  Widget _buttonTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tweet.userName, style: kTextStyleFeedTweetTitle),
        isDetail ? _buildDetailTime() : _buildTime(),
      ],
    );
  }

  void _showUserProfile() {
    final profile = UserDetailProfileEntity(
        nickname: null,
        avatar: null,
        clientId: tweet.clientId,
        miniBio: null,
        skills: null,
        activity: null);

    Modular.to.pushNamed(
      "/mainboard/users/profile",
      arguments: profile,
    );
  }
}
