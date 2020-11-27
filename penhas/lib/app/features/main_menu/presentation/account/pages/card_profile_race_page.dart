import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'card_profile_header_edit_page.dart';

class CardProfileRacePage extends StatelessWidget {
  final String content;
  final void Function(String) onChange;
  const CardProfileRacePage({
    Key key,
    @required this.content,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignSystemColors.systemBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfileHeaderEditPage(
              title: "Raça",
              onEditAction: () => showModal(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 20.0),
              child: Text(
                EnumHumanRace.map(content).label,
                style: contentTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showModal() {
    Modular.to.showDialog(
      child: AlertDialog(
        title: Text('Raça'),
        scrollable: true,
        content: Container(
          height: 350,
          child: ListView.builder(
              itemCount: datasource().length,
              itemBuilder: (BuildContext context, int index) {
                return datasource()[index];
              }),
        ),
      ),
    );
  }
}

extension _TextStyle on CardProfileRacePage {
  // TextStyle get nameTextStyle => TextStyle(
  //       fontFamily: 'Lato',
  //       fontSize: 14.0,
  //       letterSpacing: 0.45,
  //       color: DesignSystemColors.darkIndigoThree,
  //       fontWeight: FontWeight.bold,
  //     );
  TextStyle get contentTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}

extension _HumanMapper on CardProfileRacePage {
  List<Widget> datasource() {
    return HumanRace.values
        .map(
          (v) => ListTile(
              title: Text(v.label),
              leading: content == v.rawValue
                  ? Icon(Icons.check_circle_outlined)
                  : Container(width: 16),
              onTap: () => updateRace(v.rawValue)),
        )
        .toList();
  }

  void updateRace(String id) {
    onChange(id);
    Modular.to.pop();
  }
  // Widget buildDropdownList({
  //   @required BuildContext context,
  //   @required String labelText,
  //   @required String currentValue,
  //   @required List dataSource,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Theme(
  //       data: Theme.of(context)
  //           .copyWith(canvasColor: Color.fromRGBO(141, 146, 157, 1)),
  //       child: DropdownButtonFormField(
  //         isExpanded: true,
  //         decoration: InputDecoration(
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: DesignSystemColors.easterPurple),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: DesignSystemColors.easterPurple),
  //           ),
  //           border: OutlineInputBorder(
  //               borderSide: BorderSide(color: DesignSystemColors.easterPurple)),
  //           contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
  //           hintText: labelText,
  //           hintStyle: TextStyle(color: Colors.black),
  //         ),
  //         items: dataSource,
  //         onChanged: (msg) => print(),
  //         value: currentValue.isEmpty ? null : currentValue,
  //       ),
  //     ),
  //   );
  // }

  /*

  /*
  
    static List<DropdownMenuItem<String>> _buildDataSource(
      List<MenuItemModel> list) {
    return list
        .map(
          (v) => DropdownMenuItem<String>(
            child: Text(v.display),
            value: v.value,
          ),
        )
        .toList();
  }

                      return _buildDropdownList(
                        context: context,
                        labelText: 'Raça',
                        onError: controller.warningRace,
                        onChange: controller.setRace,
                        currentValue: controller.currentRace,
                        dataSource: dataSourceRace,
                      );

  Widget _buildDropdownList<T>({
    @required BuildContext context,
    @required String labelText,
    @required String onError,
    @required onChange,
    @required T currentValue,
    @required List dataSource,
  }) {
    return Theme(
      data: Theme.of(context)
          .copyWith(canvasColor: Color.fromRGBO(141, 146, 157, 1)),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          errorText: (onError?.isEmpty ?? true) ? null : onError,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        ),
        items: dataSource,
        onChanged: onChange,
        style: TextStyle(color: Colors.white),
        value: currentValue == '' ? null : currentValue,
      ),
    );
  }

   */

  static List<MenuItemModel> raceDataSource() {
    return HumanRace.values
        .map(
          (v) => MenuItemModel(_mapRaceToLabel(v), "${v.index}"),
        )
        .toList();
  }

                    Observer(builder: (_) {
                      return _buildDropdownList(
                        context: context,
                        labelText: 'Raça',
                        onError: controller.warningRace,
                        onChange: controller.setRace,
                        currentValue: controller.currentRace,
                        dataSource: dataSourceRace,
                      );


Widget _buildDropdownList<T>({
    @required BuildContext context,
    @required String labelText,
    @required String onError,
    @required onChange,
    @required T currentValue,
    @required List dataSource,
  }) {
    return Theme(
      data: Theme.of(context)
          .copyWith(canvasColor: Color.fromRGBO(141, 146, 157, 1)),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          errorText: (onError?.isEmpty ?? true) ? null : onError,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        ),
        items: dataSource,
        onChanged: onChange,
        style: TextStyle(color: Colors.white),
        value: currentValue == '' ? null : currentValue,
      ),
    );
  }


*/

}
