import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'card_profile_header_edit_page.dart';

class CardProfileBioPage extends StatelessWidget {
  final String content;
  final void Function(String) onChange;

  const CardProfileBioPage({
    Key key,
    @required this.content,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfileHeaderEditPage(
              title: "Minibio",
              onEditAction: () => showModal(context: context),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 20.0),
              child: Text(content),
            )
          ],
        ),
      ),
    );
  }
}

extension _Modal on CardProfileBioPage {
  void showModal({
    @required BuildContext context,
  }) {
    TextEditingController _controller = TextEditingController();
    _controller.text = content;

    Modular.to.showDialog(
      child: AlertDialog(
        title: Text("Editar"),
        content: TextFormField(
          controller: _controller,
          maxLines: 5,
          maxLength: 2200,
          maxLengthEnforced: true,
          decoration:
              InputDecoration(hintText: "Informe uma minibio", filled: true),
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
              onChange(_controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
