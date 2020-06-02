import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

void main() {
  TweetSessionMondel tweetSessionMondel;
  setUp(() {});

  group('TweetResponseModel', () {
    test('tweets should be a subclass of TweetSessionEntity', () async {
      // arrange
      tweetSessionMondel = TweetSessionMondel(
        false,
        TweetSessionOrder.latestFirst,
        [],
      );
      // assert
      expect(tweetSessionMondel, isA<TweetSessionEntity>());
    });
  });
}
