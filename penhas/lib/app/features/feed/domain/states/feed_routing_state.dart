import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_routing_state.freezed.dart';

@freezed
abstract class FeedRoutingState with _$FeedRoutingState {
  const factory FeedRoutingState.initial() = _Initial;
  // const factory FeedRoutingState.loaded(UserDetailProfileEntity person) =
  //     _Loaded;
  // const factory FeedRoutingState.error(String message) = _ErrorDetails;
}
