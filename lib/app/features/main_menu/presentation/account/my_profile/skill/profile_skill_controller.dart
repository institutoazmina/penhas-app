import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../authentication/presentation/shared/map_failure_message.dart';
import '../../../../../filters/domain/entities/filter_tag_entity.dart';
import '../../../../../filters/states/filter_action_observer.dart';
import '../../../../../filters/states/filter_state.dart';

part 'profile_skill_controller.g.dart';

class ProfileSkillController extends _ProfileSkillControllerBase
    with _$ProfileSkillController {
  ProfileSkillController({
    required List<FilterTagEntity> tags,
  }) : super(tags);
}

abstract class _ProfileSkillControllerBase with Store, MapFailureMessage {
  _ProfileSkillControllerBase(this._filterTags) {
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
