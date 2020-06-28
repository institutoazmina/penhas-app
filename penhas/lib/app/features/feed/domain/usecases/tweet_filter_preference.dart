import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

abstract class ITweetRepository {
  Future<Either<Failure, TweetFilterSessionEntity>> retreive();
}

class TweetFilterPreference {
  final ITweetRepository _repository;
  final IAppConfiguration _appConfiguration;

  TweetFilterPreference(
      {@required ITweetRepository repository,
      @required IAppConfiguration appConfiguration})
      : _repository = repository,
        _appConfiguration = appConfiguration;

  Future<Either<Failure, TweetFilterSessionEntity>> retreive() async {
    return _repository.retreive();
  }

  Future<void> saveCategory(List<TweetFilterCategory> categories) {
    final List<String> codes = categories.map((e) => e.id).toList();
    return _appConfiguration.saveCategoryPreference(codes: codes);
  }

  Future<void> saveTags(List<TweetFilterTag> tags) {
    final List<String> codes = tags.map((e) => e.id).toList();
    return _appConfiguration.saveTagsPreference(codes: codes);
  }
}
