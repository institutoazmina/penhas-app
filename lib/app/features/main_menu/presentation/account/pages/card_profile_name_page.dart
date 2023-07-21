import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/extension/asuka.dart';
import '../../../../../shared/design_system/colors.dart';
import 'card_profile_header_edit_page.dart';

class CardProfileNamePage extends StatelessWidget {
  const CardProfileNamePage({
    Key? key,
    required this.name,
    required this.avatar,
    required this.onChange,
  }) : super(key: key);

  final String? name;
  final String? avatar;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: DesignSystemColors.pinkishGrey),
        ),
      ),
      child: Padding(
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
              padding: const EdgeInsets.only(top: 4.0, bottom: 20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 21.0,
                    backgroundColor: const Color.fromRGBO(239, 239, 239, 1.0),
                    child: SvgPicture.network(
                      avatar!,
                      height: 27.0,
                      width: 32.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(name!, style: nameTextStyle),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
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
    final TextEditingController _controller = TextEditingController();
    _controller.text = name!;

    Modular.to.showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Editar'),
        content: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Digite o novo nome',
            filled: true,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('Enviar'),
            onPressed: () async {
              onChange(_controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
