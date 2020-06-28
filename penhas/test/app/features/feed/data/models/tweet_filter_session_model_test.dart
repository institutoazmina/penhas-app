import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/feed/data/models/tweet_filter_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  TweetFilterSessionModel sessionModel;

  setUp(() {});

  group('TweetFilterSessionModel', () {
    test('should be a subclass of TweetFilterSessionEntity', () async {
      // arrange
      sessionModel = TweetFilterSessionModel(categories: [], tags: []);
      // assert
      expect(sessionModel, isA<TweetFilterSessionEntity>());
    });

    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'feed/retrieve_fiters_tags.json');
      final expected = TweetFilterSessionModel(categories: [
        TweetFilterCategory(id: "all", isDefault: true, label: "Tudo"),
        TweetFilterCategory(
            id: "only_news", isDefault: false, label: "Apenas notícias"),
        TweetFilterCategory(
            id: "only_tweets", isDefault: false, label: "Apenas publicações"),
        TweetFilterCategory(
            id: "all_myself",
            isDefault: false,
            label: "Minhas publicações e comentários"),
      ], tags: [
        TweetFilterTag(id: '371', title: "Direitos Humanos"),
        TweetFilterTag(id: '370', title: "Elas no Congresso"),
        TweetFilterTag(id: '375', title: "Violência doméstica"),
      ]);
      // act
      final received = TweetFilterSessionModel.fromJson(jsonData);
      // assert
      expect(received, expected);
    });
  });
}
