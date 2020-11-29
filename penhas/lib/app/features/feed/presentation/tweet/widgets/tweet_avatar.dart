import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class TweetAvatar extends StatelessWidget {
  final TweetEntity tweet;
  const TweetAvatar({
    Key key,
    @required this.tweet,
  })  : assert(tweet != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color.fromRGBO(239, 239, 239, 1.0),
      radius: 24.0,
      child: avatar(),
    );
  }
}

extension _PrivateMethod on TweetAvatar {
  Widget avatar() {
    return SvgPicture.network(
      tweet.avatar,
      color: DesignSystemColors.darkIndigo,
      height: 36,
    );
  }
}
/*

void _showUserProfile() {
    final routeOption = FeedRouterType.profile(tweet.clientId);

    Modular.to.pushNamed(
      "/mainboard/tweet/perfil_chat",
      arguments: routeOption,
    );
  }


                      avatar: 
*/
