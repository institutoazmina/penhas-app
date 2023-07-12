import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../authentication/presentation/shared/map_failure_message.dart';
import '../domain/entities/filter_tag_entity.dart';
import '../states/filter_action_observer.dart';
import '../states/filter_state.dart';

part 'filter_controller.g.dart';

class FilterController extends _FilterControllerBase with _$FilterController {
  FilterController({
    required List<FilterTagEntity> tags,
  }) : super(tags);
}

abstract class _FilterControllerBase with Store, MapFailureMessage {
  _FilterControllerBase(this._filterTags) {
    currentState = FilterState.loaded(_filterTags);
  }

  final List<FilterTagEntity> _filterTags;

  @observable
  FilterState currentState = const FilterState.initial();

  @action
  Future<void> reset() async {
    Modular.to.pop(const FilterActionObserver.reset());
  }

  @action
  Future<void> setTags(List<FilterTagEntity> tags) async {
    Modular.to.pop(FilterActionObserver.updated(tags));
  }
}
