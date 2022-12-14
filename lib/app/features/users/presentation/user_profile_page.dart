import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/features/users/domain/states/user_profile_state.dart';
import 'package:penhas/app/features/users/presentation/user_profile_controller.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

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
      body: Observer(
        builder: (_) {
          return bodyBuilder(controller.currentState);
        },
      ),
    );
  }
}

extension _UserProfilePagePrivate on _UserProfilePageState {
  Widget bodyBuilder(UserProfileState state) {
    return state.when(
      initial: () => empty(),
      loaded: (user) => loaded(user),
      error: (message) => empty(),
    );
  }

  Widget empty() => Container(color: DesignSystemColors.systemBackgroundColor);

  Widget loaded(UserDetailEntity user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildHeader(user.profile),
        buildContent(user.profile),
        if (user.isMyself)
          Container()
        else
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 70.0,
              vertical: 20.0,
            ),
            child: SizedBox(
              height: 44,
              child: RaisedButton(
                onPressed: () => controller.openChannel(),
                elevation: 0,
                color: DesignSystemColors.ligthPurple,
                shape: kButtonShapeFilled,
                child: Text(
                  'Conversar',
                  style: buttomTitleStyle,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildHeader(UserDetailProfileEntity user) {
    return Container(
      color: DesignSystemColors.easterPurple,
      height: 120,
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white38,
            child: SvgPicture.network(user.avatar!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              user.nickname!,
              style: nameStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget buildContent(UserDetailProfileEntity user) {
    final List<String> skills = user.skills!.split(',');
    skills.removeWhere((e) => e.isEmpty);

    return Container(
      color: DesignSystemColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text('Minibio', style: headerStyle),
            ),
            Text(
              user.miniBio ?? '',
              style: bodyStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text('Dispon??vel para falar sobre', style: headerStyle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Tags(
                spacing: 12,
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
        title: item,
        index: index,
        elevation: 0,
        textStyle: tagStyle,
        textColor: DesignSystemColors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      ),
    );
  }

  TextStyle get nameStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get headerStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );

  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        height: 1.2,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );

  TextStyle get tagStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.normal,
      );

  TextStyle get buttomTitleStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.bold,
      );
}
