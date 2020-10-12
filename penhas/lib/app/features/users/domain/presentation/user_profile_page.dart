import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:penhas/app/features/users/domain/presentation/user_profile_controller.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState
    extends ModularState<UserProfilePage, UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignSystemColors.systemBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(),
          buildContent(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 70.0,
              vertical: 20.0,
            ),
            child: SizedBox(
              height: 44,
              child: RaisedButton(
                onPressed: () => print("Ola mundo!"),
                elevation: 0,
                color: DesignSystemColors.ligthPurple,
                shape: kButtonShapeFilled,
                child: Text(
                  "Conversar",
                  style: buttomTitleStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension _UserProfilePagePrivate on _UserProfilePageState {
  Widget buildHeader() {
    return Container(
      color: DesignSystemColors.easterPurple,
      height: 120,
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            child: SvgPicture.network(controller.person.avatar),
            backgroundColor: Colors.white38,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              controller.person.nickname,
              style: nameStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget buildContent() {
    final List<String> skills = controller.person.skills.split(",");
    return Container(
      color: DesignSystemColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text("Minibio", style: headerStyle),
            ),
            Text(
              controller.person.miniBio ?? "",
              style: bodyStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text("Disponível para falar sobre", style: headerStyle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Tags(
                spacing: 12,
                symmetry: false,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                itemCount: skills.length,
                itemBuilder: (int index) {
                  final item = skills[index];
                  return builtTagItem(item, index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Tooltip builtTagItem(String item, int index) {
    return Tooltip(
        message: item,
        child: ItemTags(
          activeColor: DesignSystemColors.easterPurple,
          color: DesignSystemColors.easterPurple,
          active: true,
          title: item,
          index: index,
          elevation: 0,
          textStyle: tagStyle,
          textColor: DesignSystemColors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        ));
  }

  TextStyle get nameStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 16.0,
      letterSpacing: 0.5,
      color: DesignSystemColors.white,
      fontWeight: FontWeight.bold);

  TextStyle get headerStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 16.0,
      letterSpacing: 0.5,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.bold);

  TextStyle get bodyStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.4,
      height: 1.2,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.normal);

  TextStyle get tagStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 12.0,
      letterSpacing: 0.4,
      color: DesignSystemColors.white,
      fontWeight: FontWeight.normal);

  TextStyle get buttomTitleStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 12.0,
      letterSpacing: 0.4,
      color: DesignSystemColors.white,
      fontWeight: FontWeight.bold);
}
