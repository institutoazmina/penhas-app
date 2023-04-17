import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/tweet_entity.dart';

part 'feed_state.freezed.dart';

@freezed
class FeedState with _$FeedState {
  const factory FeedState.initial() = _InitialState;
  const factory FeedState.loaded(List<TweetTiles> items) = _LoadedState;
  const factory FeedState.error(String message) = _ErrorState;
}

extension FeedStateExt on FeedState {
  bool get isInitial => maybeWhen(initial: () => true, orElse: () => false);
  bool get isError => maybeWhen(error: (_) => true, orElse: () => false);
}
