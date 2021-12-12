import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/extension/asuka.dart';
<<<<<<< HEAD
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_header_edit_page.dart';
=======
>>>>>>> Fix code syntax
import 'package:penhas/app/shared/design_system/colors.dart';

class CardProfilePasswordPage extends StatelessWidget {
  const CardProfilePasswordPage({
    Key? key,
    required this.content,
    required this.onChange,
  }) : super(key: key);

  final String content;
  final void Function(String, String) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignSystemColors.systemBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfileHeaderEditPage(
              title: 'Senha',
              onEditAction: () => showModal(context: context),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 20.0),
              child: Text(
                content,
                style: contentTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension _Modal on CardProfilePasswordPage {
  void showModal({required BuildContext context}) {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController oldPasswordController = TextEditingController();

    Modular.to.showDialog(
<<<<<<< HEAD
      builder: (context) => AlertDialog(
        title: const Text('Email'),
=======
      builder: (_) => AlertDialog(
        title: Text('Email'),
>>>>>>> Fix code syntax
        scrollable: true,
        content: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              controller: newPasswordController,
              decoration: const InputDecoration(
                hintText: 'Digite a nova senha',
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              controller: oldPasswordController,
              decoration: const InputDecoration(
                hintText: 'Digite a senha atual',
                filled: true,
              ),
            ),
          ],
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
              onChange(
                newPasswordController.text,
                oldPasswordController.text,
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

extension _TextStyle on CardProfilePasswordPage {
  TextStyle get contentTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}
