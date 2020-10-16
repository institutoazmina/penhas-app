import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class FilterLoadedStatePage extends StatelessWidget {
  final void Function() onResetAction;
  final void Function(List<FilterTagEntity>) onAplyFilterAction;
  final List<FilterTagEntity> tags;

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  FilterLoadedStatePage({
    Key key,
    @required this.tags,
    @required this.onResetAction,
    @required this.onAplyFilterAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtros'),
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: SizedBox.expand(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              color: DesignSystemColors.systemBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 20),
                    child: Text(
                      'Selecione os temas de seu interesse:',
                      style: filterTitleTextStyle,
                    ),
                  ),
                  Expanded(
                    child: Tags(
                      spacing: 12.0,
                      symmetry: false,
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
                    mainAxisSize: MainAxisSize.max,
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

extension _FilterLoadedStatePageMethods on FilterLoadedStatePage {
  Tooltip builtTagItem(FilterTagEntity item, int index) {
    return Tooltip(
      message: item.label,
      child: ItemTags(
        activeColor: DesignSystemColors.easterPurple,
        title: item.label,
        index: index,
        active: item.isSelected,
        customData: item.id,
        elevation: 0,
        textStyle: tagTitleTextStyle,
        textColor: DesignSystemColors.easterPurple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
      ),
    );
  }

  Widget buildResetPasswordButton() {
    return SizedBox(
      height: 40,
      width: 160,
      child: FlatButton(
        onPressed: onResetAction,
        color: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(
          "Limpar",
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
      child: RaisedButton(
        onPressed: () => applyFilter(),
        elevation: 0,
        color: DesignSystemColors.ligthPurple,
        child: Text("Aplicar filtro",
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.white,
              letterSpacing: 0.45,
            )),
        shape: kButtonShapeOutlinePurple,
      ),
    );
  }

  void applyFilter() {
    if (_tagStateKey.currentState == null) {
      onAplyFilterAction([]);
    }

    final seletedTags = _tagStateKey.currentState.getAllItem
        .where((e) => e.active)
        .map((e) => e.customData)
        .map((e) => e as String)
        .map((e) => tags.firstWhere((t) => t.id == e))
        .toList();

    onAplyFilterAction(seletedTags);
  }
}

extension _FilterLoadedStatePageTextStyle on FilterLoadedStatePage {
  TextStyle get filterTitleTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        color: DesignSystemColors.darkIndigoThree,
      );

  TextStyle get tagTitleTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        color: DesignSystemColors.ligthPurple,
      );
}
