import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_router_type.freezed.dart';

@freezed
abstract class FeedRouterType with _$FeedRouterType {
  const factory FeedRouterType.chat(int clientId) = _Chat;
  const factory FeedRouterType.profile(int clientId) = _Profile;
}
