import 'package:meta/meta.dart';

enum TweetRouterOptionEnum { chat, profile }

class TweetRouterOption {
  final String clientId;
  final TweetRouterOptionEnum routerOption;

  TweetRouterOption({
    @required this.clientId,
    @required this.routerOption,
  });
}
