import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'card_profile_header_edit_page.dart';

class CardProfilePasswordPage extends StatelessWidget {
  final String content;
  final void Function(String, String) onChange;

  const CardProfilePasswordPage({
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
          top: 0.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfileHeaderEditPage(
              title: "Senha",
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
  void showModal({@required BuildContext context}) {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController oldPasswordController = TextEditingController();

    Modular.to.showDialog(
      child: AlertDialog(
        title: Text('Email'),
        scrollable: true,
        content: Column(
          children: [
            TextFormField(
              controller: newPasswordController,
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: 'Digite a nova senha', filled: true),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: oldPasswordController,
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: 'Digite a senha atual', filled: true),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Enviar'),
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
  TextStyle get contentTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}
