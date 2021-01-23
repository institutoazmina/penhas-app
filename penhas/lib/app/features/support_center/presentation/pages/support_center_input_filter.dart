import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class SupportCenterInputFilter extends StatelessWidget {
  final int totalOfFilter;
  final String initialValue;
  final void Function() onFilterAction;
  final void Function(String) onKeywordsAction;
  final TextEditingController _textController = TextEditingController();

  SupportCenterInputFilter({
    Key key,
    this.totalOfFilter = 0,
    this.initialValue,
    @required this.onFilterAction,
    @required this.onKeywordsAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _textController.value = TextEditingValue(text: initialValue ?? "");
    final filterTitle =
        (totalOfFilter > 0) ? "Filtros ($totalOfFilter)" : "Filtros";

    return Container(
      color: DesignSystemColors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'Encontre um ponto de apoio próximo de você',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                IconButton(
                  icon: Icon(
                    Icons.help_outline,
                    color: DesignSystemColors.bluishPurple,
                  ),
                  onPressed: () async {
                    Modular.to.showDialog(
                      barrierDismissible: true,
                      builder: (context) {
                        return AlertDialog(
                          content: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                  'Pontos de apoio são serviços que integram toda a rede de acolhimento a mulheres vítimas de violência, como por exemplo delegacia da mulher, hospital, centro de atendimento à mulher em situação de violência, entre outros.',
                                  style: kTextStyleAlertDialogDescription)),
                          actions: [
                            SizedBox(
                              width: 120,
                              child: FlatButton(
                                color: DesignSystemColors.easterPurple,
                                child: Text('Entendi',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () => Modular.to.pop(),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: DesignSystemColors.white,
                    border: Border.all(color: DesignSystemColors.ligthPurple),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: "Busque por cidade, UF ou nome do ponto de apoio",
                            hintStyle: TextStyle(fontSize: 11)),
                            textCapitalization: TextCapitalization.none,
                            controller: _textController,
                            onSubmitted: (t) => _submitKeywordFilter(context),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: DesignSystemColors.easterPurple,
                        ),
                        onPressed: () => _submitKeywordFilter(context),
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                onPressed: onFilterAction,
                elevation: 0,
                color: DesignSystemColors.ligthPurple,
                shape: kButtonShapeFilled,
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
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    onKeywordsAction(_textController.text);
  }
}
