import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/widgets/tags/tags.dart';
import '../../../../filters/domain/entities/filter_tag_entity.dart';
import 'card_profile_header_edit_page.dart';

class CardProfileSkillPage extends StatelessWidget {
  const CardProfileSkillPage({
    Key? key,
    required this.skills,
    required this.onEditAction,
  }) : super(key: key);

  final List<FilterTagEntity?> skills;
  final void Function() onEditAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardProfileHeaderEditPage(
            title: 'Disponível para falar sobre',
            onEditAction: onEditAction,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
            child: Tags(
              spacing: 12.0,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              itemCount: skills.length,
              itemBuilder: (int index) {
                final item = skills[index]!;
                return builtTagItem(item, index);
              },
            ),
          )
        ],
      ),
    );
  }
}

extension _TextStyle on CardProfileSkillPage {
  Tooltip builtTagItem(FilterTagEntity item, int index) {
    return Tooltip(
      message: item.label,
      child: TagItem(
        activeColor: DesignSystemColors.easterPurple,
        title: item.label!,
        index: index,
        active: item.isSelected,
        customData: item.id,
        elevation: 0,
        pressEnabled: false,
        textStyle: tagTitleTextStyle,
        textColor: DesignSystemColors.easterPurple,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      ),
    );
  }

  TextStyle get tagTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        color: DesignSystemColors.ligthPurple,
      );
}
