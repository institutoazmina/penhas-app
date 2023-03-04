import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../shared/design_system/text_styles.dart';
import '../../../../../shared/widgets/bottom_sheet_actions_widget.dart';
import '../../../domain/entities/tweet_entity.dart';
import '../../../domain/states/feed_router_type.dart';
import '../../stores/tweet_controller.dart';

class TweetTitle extends StatelessWidget {
  const TweetTitle({
    Key? key,
    required this.tweet,
    required BuildContext context,
    required this.controller,
    this.isDetail = false,
  })  : _context = context,
        super(key: key);

  final TweetEntity tweet;
  final BuildContext _context;
  final ITweetController? controller;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return tweet.anonymous
        ? _showAnonymousHeader()
        : _showAuthenticatedHeader();
  }

  Widget _buildTime() {
    timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
    final parsedTime = _mapServerUtcToLocalDate(tweet.createdAt);
    return Text(
      timeago.format(parsedTime, locale: 'pt_br'),
      style: kTextStyleFeedTweetTime,
    );
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
        '$day/$month/${parsedTime.year} · $hour:$minute',
        style: kTextStyleFeedTweetTime,
      ),
    );
  }

  String _stringfyFormatted(int value) {
    return value > 9 ? '$value' : '0$value';
  }

  DateTime _mapServerUtcToLocalDate(String? time) {
    final utcEnabled = '${time}Z';

    return DateTime.parse(utcEnabled).toLocal();
  }

  Future<void> _showTweetAction() async {
    await showModalBottomSheet(
      context: _context,
      builder: (_) => BottomSheetActionsContentWidget(actions: _buildAction()),
    );
  }

  List<Widget> _buildAction() {
    return [
      if (tweet.meta.owner)
        ListTile(
          leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_delete.svg',
          ),
          title: const Text('Apagar'),
          onTap: () {
            controller!
                .delete(tweet)
                .whenComplete(() => Navigator.of(_context).pop());
          },
        ),
      if (!tweet.anonymous && !tweet.meta.owner)
        ListTile(
          leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_chat.svg',
          ),
          title: const Text('Conversar'),
          onTap: () => _showUserChat(),
        ),
      if (!tweet.meta.owner)
        ListTile(
          leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_report.svg',
          ),
          title: const Text('Denunciar'),
          onTap: () {
            Navigator.of(_context).pop();
            controller!.report(tweet);
          },
        ),
    ];
  }

  Widget _showAnonymousHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(tweet.userName, style: kTextStyleFeedTweetTitle),
        ),
        if (isDetail) _buildDetailTime() else _buildTime(),
        if (controller != null)
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showTweetAction(),
          ),
      ],
    );
  }

  Widget _showAuthenticatedHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          // ignore: deprecated_member_use
          child: FlatButton(
            onPressed: () => _showUserProfile(),
            color: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: EdgeInsets.zero,
            child: _buttonTitle(),
          ),
        ),
        if (controller != null)
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showTweetAction(),
          ),
      ],
    );
  }

  Widget _buttonTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tweet.userName, style: kTextStyleFeedTweetTitle),
        if (isDetail) _buildDetailTime() else _buildTime(),
      ],
    );
  }

  void _showUserProfile() {
    final routeOption = FeedRouterType.profile(tweet.clientId);

    Modular.to.pushNamed(
      '/mainboard/tweet/perfil_chat',
      arguments: routeOption,
    );
  }

  void _showUserChat() {
    final routeOption = FeedRouterType.chat(tweet.clientId);

    Modular.to.pushNamed(
      '/mainboard/tweet/perfil_chat',
      arguments: routeOption,
    );
  }
}
