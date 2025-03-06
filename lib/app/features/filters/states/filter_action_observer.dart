import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/filter_tag_entity.dart';

part 'filter_action_observer.freezed.dart';

@freezed
class FilterActionObserver with _$FilterActionObserver {
  const factory FilterActionObserver.reset() = _Reset;
  const factory FilterActionObserver.updated(List<FilterTagEntity> tags) =
      _Updated;
}
