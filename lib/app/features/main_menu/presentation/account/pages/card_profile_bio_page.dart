import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/extension/asuka.dart';
import '../../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import 'card_profile_header_edit_page.dart';

class CardProfileBioPage extends StatelessWidget {
  const CardProfileBioPage({
    super.key,
    required this.content,
    required this.onChange,
  });

  final String content;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
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
    );
  }
}

extension _Modal on CardProfileBioPage {
  void showModal({
    required BuildContext context,
  }) {
    final TextEditingController controller = TextEditingController();
    controller.text = content;

    Modular.to.showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Editar'),
        content: TextFormField(
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: controller,
          maxLines: 5,
          maxLength: 2200,
          decoration: const InputDecoration(
            hintText: 'Informe uma minibio',
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
