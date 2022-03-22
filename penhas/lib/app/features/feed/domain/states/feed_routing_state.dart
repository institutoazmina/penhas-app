import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_routing_state.freezed.dart';

@freezed
class FeedRoutingState with _$FeedRoutingState {
  const factory FeedRoutingState.initial(String title) = _Initial;
  const factory FeedRoutingState.error(String title, String message) =
      _ErrorDetails;
}
