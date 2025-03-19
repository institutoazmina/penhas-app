import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/skill/pages/profile_skill_loaded_widget.dart';

import '../../../../../../../../utils/golden_tests.dart';

void main() {
  group(ProfileSkillLoadedWidget, () {
    screenshotTestSimplified(
      'should render correctly',
      fileName: 'profile_skill_loaded_widget',
      pageBuilder: () => Scaffold(
        body: ProfileSkillLoadedWidget(
          tags: const [
            FilterTagEntity(
              id: '1',
              label: 'Skill 1',
              isSelected: false,
            ),
            FilterTagEntity(
              id: '2',
              label: 'Skill 2',
              isSelected: true,
            )
          ],
          onApplyFilterAction: (List<FilterTagEntity> tags) {},
          onResetAction: () {},
        ),
      ),
    );
  });
}
