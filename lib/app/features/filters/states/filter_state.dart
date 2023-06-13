import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/filter_tag_entity.dart';

part 'filter_state.freezed.dart';

@freezed
class FilterState with _$FilterState {
  const factory FilterState.initial() = _Initial;
  const factory FilterState.loaded(List<FilterTagEntity> tags) = _Loaded;
}
