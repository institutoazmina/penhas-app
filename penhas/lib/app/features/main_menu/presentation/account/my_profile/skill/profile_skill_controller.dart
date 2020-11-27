import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/filters/states/filter_action_observer.dart';
import 'package:penhas/app/features/filters/states/filter_state.dart';

part 'profile_skill_controller.g.dart';

class ProfileSkillController extends _ProfileSkillControllerBase
    with _$ProfileSkillController {
  ProfileSkillController({
    @required List<FilterTagEntity> tags,
  }) : super(tags);
}

abstract class _ProfileSkillControllerBase with Store, MapFailureMessage {
  final List<FilterTagEntity> _filterTags;

  _ProfileSkillControllerBase(this._filterTags) {
    currentState = FilterState.loaded(_filterTags);
  }

  @observable
  FilterState currentState = FilterState.initial();

  @action
  Future<void> reset() async {
    Modular.to.pop(FilterActionObserver.reset());
  }

  @action
  Future<void> setTags(List<FilterTagEntity> tags) async {
    Modular.to.pop(FilterActionObserver.updated(tags));
  }
}
