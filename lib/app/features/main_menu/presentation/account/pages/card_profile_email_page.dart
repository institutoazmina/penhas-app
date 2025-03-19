import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/extension/asuka.dart';
import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import 'card_profile_header_edit_page.dart';

class CardProfileEmailPage extends StatelessWidget {
  const CardProfileEmailPage({
    super.key,
    required this.content,
    required this.onChange,
  });

  final String? content;
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
              title: 'Email',
              onEditAction: () => showModal(context: context),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 20.0),
              child: Text(
                content!,
                style: contentTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension _Modal on CardProfileEmailPage {
  void showModal({required BuildContext context}) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Modular.to.showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Email'),
        scrollable: true,
        content: Column(
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Digite o novo email',
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Digite a senha atual',
                filled: true,
              ),
            ),
          ],
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
              onChange(emailController.text, passwordController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

extension _TextStyle on CardProfileEmailPage {
  TextStyle get contentTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}
