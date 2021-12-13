import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_filter_preference_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

class TweetFilterPreference {
  final ITweetFilterPreferenceRepository? _repository;
  List<String?> _currentTags = [];
  List<String> _currentCategory = [];

  TweetFilterPreference({
    required ITweetFilterPreferenceRepository? repository,
  }) : _repository = repository;

  final ITweetFilterPreferenceRepository? _repository;
  List<String> _currentTags = [];
  List<String> categories = [];

  Future<Either<Failure, TweetFilterSessionEntity>> retreive() async {
    final serverResponse = await _repository!.retreive();

    return serverResponse.fold(
      (failure) => left(failure),
      (session) => _rebuildResponse(session),
    );
  }

  Either<Failure, TweetFilterSessionEntity> _rebuildResponse(
    TweetFilterSessionEntity response,
  ) {
    if (categories.isEmpty && _currentTags.isEmpty) {
      return right(response);
    }

    List<TweetFilterEntity>? rebuildedCategory;
    if (_currentCategory.isNotEmpty) {
      final setCategory = Set<String>.from(_currentCategory);
      final indexCategory = response.categories.indexWhere(
        (e) => setCategory.contains(e.id),
      );
      if (indexCategory >= 0) {
        rebuildedCategory = rebuildedCategory
            .map((e) => e.copyWith(isSelected: setCategory.contains(e.id)))
            .toList();
      }
    }

    List<TweetFilterEntity>? rebuildedTags;
    if (_currentTags.isNotEmpty) {
      final setTags = Set<String>.from(_currentTags);
      rebuildedTags = rebuildedTags
          .map((e) => e.copyWith(isSelected: setTags.contains(e.id)))
          .toList();
    }

    return right(TweetFilterSessionEntity(
        categories: rebuildedCategory ?? response.categories,
        tags: rebuildedTags ?? response.tags));
  }

  void saveCategory(List<String> categories) {
    _currentCategory = categories;
  }

  void saveTags(List<String?> tags) {
    _currentTags = tags;
  }

  void saveTags(List<String?> tags) {
    _currentTags = tags.whereNotNull().toList();
  }

  List<String?> getTags() {
    return _currentTags;
  }
}
