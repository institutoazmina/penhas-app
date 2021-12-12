import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/extension/asuka.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_header_edit_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class CardProfileBioPage extends StatelessWidget {
  const CardProfileBioPage({
    required Key key,
    required this.content,
    required this.onChange,
  }) : super(key: key);

  final String content;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfileHeaderEditPage(
              title: 'Minibio',
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
    required BuildContext context,
  }) {
    final TextEditingController _controller = TextEditingController();
    _controller.text = content;

    Modular.to.showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Editar'),
        content: TextFormField(
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: _controller,
          maxLines: 5,
          maxLength: 2200,
          decoration: const InputDecoration(
            hintText: 'Informe uma minibio',
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
