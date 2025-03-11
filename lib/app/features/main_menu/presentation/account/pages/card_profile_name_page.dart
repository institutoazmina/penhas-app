import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/extension/asuka.dart';
import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/widgets/badges/user_badge_widget.dart';
import '../../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../../appstate/domain/entities/user_profile_badge_entity.dart';
import 'card_profile_header_edit_page.dart';

class CardProfileNamePage extends StatelessWidget {
  const CardProfileNamePage({
    Key? key,
    required this.name,
    required this.onChange,
    this.avatar,
    required this.badges,
  }) : super(key: key);

  final String? name;
  final String? avatar;
  final void Function(String) onChange;
  final List<UserProfileBadgeEntity> badges;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Column(
        children: [
          CardProfileHeaderEditPage(
            title: 'Apelido',
            onEditAction: () => showModal(context: context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 21.0,
                  backgroundColor: const Color.fromRGBO(239, 239, 239, 1.0),
                  child: (avatar == null || avatar!.isEmpty)
                      ? const SizedBox.shrink()
                      : SvgPicture.network(
                          avatar!,
                          height: 27.0,
                          width: 32.0,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Row(
                    children: [
                      Text(name!, style: nameTextStyle),
                      buildBadgeWidget(badges)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget buildBadgeWidget(List<UserProfileBadgeEntity> badges) {
  if (badges.isEmpty) {
    return const SizedBox.shrink();
  }
  var onlyInlineBadges = <UserProfileBadgeEntity>[];

  for (final badge in badges) {
    if (badge.style != 'inline-block') {
      onlyInlineBadges.add(badge);
    }
  }

  return Row(
    children: onlyInlineBadges
        .map((badge) => Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: UserBadgeWidget(
              badgeDescription: badge.description,
              badgeImageUrl: badge.imageUrl,
              badgeName: badge.name,
              badgePopUp: badge.popUp,
              badgeShowDescription: badge.showDescription,
              isLightBackground: true,
            )))
        .toList(),
  );
}

extension _TextStyle on CardProfileNamePage {
  TextStyle get nameTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
}

extension _Dialog on CardProfileNamePage {
  void showModal({required BuildContext context}) {
    final TextEditingController controller = TextEditingController();
    controller.text = name!;

    Modular.to.showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Editar'),
        content: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Digite o novo nome',
            filled: true,
          ),
        ),
        actions: <Widget>[
          PenhasButton.text(
            child: const Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          PenhasButton.text(
            child: const Text('Enviar'),
            onPressed: () async {
              onChange(controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
