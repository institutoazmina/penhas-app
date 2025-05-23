import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/extension/asuka.dart';
import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import 'support_center_help_alert.dart';

class SupportCenterInputFilter extends StatelessWidget {
  SupportCenterInputFilter({
    super.key,
    this.totalOfFilter = 0,
    this.initialValue,
    required this.onFilterAction,
    required this.onKeywordsAction,
  });

  final int totalOfFilter;
  final String? initialValue;
  final void Function() onFilterAction;
  final void Function(String) onKeywordsAction;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textController.value = TextEditingValue(text: initialValue ?? '');
    final filterTitle =
        (totalOfFilter > 0) ? 'Filtros ($totalOfFilter)' : 'Filtros';

    return Container(
      color: DesignSystemColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Encontre um ponto de apoio próximo de você',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.help_outline,
                    color: DesignSystemColors.bluishPurple,
                  ),
                  onPressed: () async {
                    Modular.to.showDialog(
                      builder: (_) => const SupportCenterHelpAlert(),
                    );
                  },
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: DesignSystemColors.white,
                    border: Border.all(color: DesignSystemColors.ligthPurple),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: TextField(
                            decoration: const InputDecoration.collapsed(
                              hintText:
                                  'Busque por cidade, UF ou nome do ponto de apoio',
                              hintStyle: TextStyle(fontSize: 11),
                            ),
                            controller: _textController,
                            onSubmitted: (t) => _submitKeywordFilter(context),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: DesignSystemColors.easterPurple,
                        ),
                        onPressed: () => _submitKeywordFilter(context),
                      ),
                    ],
                  ),
                ),
              ),
              PenhasButton.roundedFilled(
                onPressed: onFilterAction,
                child: Text(
                  filterTitle,
                  style: kTextStyleDefaultFilledButtonLabel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitKeywordFilter(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    onKeywordsAction(_textController.text);
  }
}
