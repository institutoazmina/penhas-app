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
      sessionModel = TweetFilterSessionModel(categories: const [], tags: const []);
      // assert
      expect(sessionModel, isA<TweetFilterSessionEntity>());
    });

    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'feed/retrieve_fiters_tags.json');
      final expected = TweetFilterSessionModel(categories: [
        TweetFilterEntity(id: 'all', isSelected: true, label: 'Tudo'),
        TweetFilterEntity(
            id: 'only_news', isSelected: false, label: 'Apenas notícias',),
        TweetFilterEntity(
            id: 'only_tweets', isSelected: false, label: 'Apenas publicações',),
        TweetFilterEntity(
            id: 'all_myself',
            isSelected: false,
            label: 'Minhas publicações e comentários',),
      ], tags: [
        TweetFilterEntity(
            id: '371', label: 'Direitos Humanos', isSelected: false,),
        TweetFilterEntity(
            id: '370', label: 'Elas no Congresso', isSelected: false,),
        TweetFilterEntity(
            id: '375', label: 'Violência doméstica', isSelected: false,),
      ],);
      // act
      final received = TweetFilterSessionModel.fromJson(jsonData);
      // assert
      expect(received, expected);
    });
  });
}
