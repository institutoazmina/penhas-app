import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/entities/tweet_entity.dart';
import '../../../domain/states/feed_router_type.dart';

class TweetAvatar extends StatelessWidget {
  const TweetAvatar({
    Key? key,
    required this.tweet,
  }) : super(key: key);

  final TweetEntity tweet;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color.fromRGBO(239, 239, 239, 1.0),
      radius: 24.0,
      child: tweet.anonymous ? anonymousAvatar() : authenticatedAvatar(),
    );
  }
}

extension _PrivateMethod on TweetAvatar {
  Widget avatar() {
    return SvgPicture.network(
      tweet.avatar,
      //color: DesignSystemColors.darkIndigo,
      height: 36,
    );
  }

  Widget anonymousAvatar() {
    return avatar();
  }

  Widget authenticatedAvatar() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () => showUserProfile(),
      color: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: avatar(),
    );
  }

  void showUserProfile() {
    final routeOption = FeedRouterType.profile(tweet.clientId);
    Modular.to.pushNamed(
      '/mainboard/tweet/perfil_chat',
      arguments: routeOption,
    );
  }
}
