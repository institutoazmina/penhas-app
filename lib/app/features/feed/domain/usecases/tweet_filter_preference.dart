import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/tweet_filter_preference_repository.dart';
import '../entities/tweet_filter_session_entity.dart';

class TweetFilterPreference {
  TweetFilterPreference({
    required ITweetFilterPreferenceRepository repository,
  }) : _repository = repository;

  final ITweetFilterPreferenceRepository _repository;
  List<String> _currentTags = [];
  List<String> categories = [];

  Future<Either<Failure, TweetFilterSessionEntity>> retrieve() async {
    final serverResponse = await _repository.retrieve();

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

    List<TweetFilterEntity> rebuildedCategory = response.categories;
    if (categories.isNotEmpty) {
      final setCategory = Set<String>.from(categories);
      final indexCategory = response.categories.indexWhere(
        (e) => setCategory.contains(e.id),
      );
      if (indexCategory >= 0) {
        rebuildedCategory = rebuildedCategory
            .map((e) => e.copyWith(isSelected: setCategory.contains(e.id)))
            .toList();
      }
    }

    List<TweetFilterEntity> rebuildedTags = response.tags;
    if (_currentTags.isNotEmpty) {
      final setTags = Set<String>.from(_currentTags);
      rebuildedTags = rebuildedTags
          .map((e) => e.copyWith(isSelected: setTags.contains(e.id)))
          .toList();
    }

    return right(
      TweetFilterSessionEntity(
        categories: rebuildedCategory,
        tags: rebuildedTags,
      ),
    );
  }

  void saveTags(List<String?> tags) {
    _currentTags = tags.nonNulls.toList();
  }

  List<String> getTags() {
    return _currentTags;
  }
}
