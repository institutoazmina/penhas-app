import 'package:flutter/material.dart';

import '../../../../../../../shared/design_system/colors.dart';
import '../../../../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../../../../../shared/design_system/widgets/tags/tags.dart';
import '../../../../../../filters/domain/entities/filter_tag_entity.dart';

class ProfileSkillLoadedWidget extends StatelessWidget {
  ProfileSkillLoadedWidget({
    Key? key,
    required this.tags,
    required this.onResetAction,
    required this.onApplyFilterAction,
  }) : super(key: key);

  final void Function() onResetAction;
  final void Function(List<FilterTagEntity>) onApplyFilterAction;
  final List<FilterTagEntity> tags;

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habilidades'),
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: SizedBox.expand(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: DesignSystemColors.systemBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 20),
                    child: Text(
                      'Selecione os temas que você está disponível para ajudar:',
                      style: filterTitleTextStyle,
                    ),
                  ),
                  Expanded(
                    child: Tags(
                      spacing: 12.0,
                      key: _tagStateKey,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      itemCount: tags.length,
                      itemBuilder: (int index) {
                        final item = tags[index];
                        return builtTagItem(item, index);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildResetPasswordButton(),
                      buildApplyButton(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension _FilterLoadedStatePageMethods on ProfileSkillLoadedWidget {
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

  Widget buildResetPasswordButton() {
    return SizedBox(
      height: 40,
      width: 160,
      child: PenhasButton.text(
        onPressed: onResetAction,
        child: const Text(
          'Limpar',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: DesignSystemColors.easterPurple,
            decoration: TextDecoration.underline,
            letterSpacing: 0.45,
          ),
        ),
      ),
    );
  }

  Widget buildApplyButton() {
    return SizedBox(
      height: 40,
      width: 160,
      child: PenhasButton.roundedFilled(
        onPressed: () => applyFilter(),
        child: const Text(
          'Atualizar',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.white,
            letterSpacing: 0.45,
          ),
        ),
      ),
    );
  }

  void applyFilter() {
    if (_tagStateKey.currentState == null) {
      onApplyFilterAction([]);
    }

    final List<FilterTagEntity> selectedTags = _tagStateKey
            .currentState?.getAllItem
            .where((e) => e.active)
            .map((e) => e.customData)
            .whereType<String>()
            .map((e) => tags.firstWhere((t) => t.id == e))
            .toList() ??
        List.empty();

    onApplyFilterAction(selectedTags);
  }
}

extension _FilterLoadedStatePageTextStyle on ProfileSkillLoadedWidget {
  TextStyle get filterTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        color: DesignSystemColors.darkIndigoThree,
      );

  TextStyle get tagTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        color: DesignSystemColors.ligthPurple,
      );
}
