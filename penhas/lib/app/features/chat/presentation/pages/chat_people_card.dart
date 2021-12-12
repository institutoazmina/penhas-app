import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatPeopleCard extends StatelessWidget {
  const ChatPeopleCard({
    Key? key,
    required this.person,
    required this.onPressed,
  }) : super(key: key);

  final UserDetailProfileEntity person;
  final void Function(UserDetailProfileEntity person) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(person),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[350]!),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromRGBO(239, 239, 239, 1.0),
                radius: 20,
                child: SvgPicture.network(person.avatar!),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 16),
                      Text(person.nickname!, style: cardTitleTextStyle),
                      Text(person.activity!, style: cardStatusTextStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension _ChatTalkCardPrivate on ChatPeopleCard {
  TextStyle get cardTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
  TextStyle get cardStatusTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.warnGrey,
        fontWeight: FontWeight.normal,
      );
}
