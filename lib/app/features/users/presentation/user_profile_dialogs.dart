import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/design_system/text_styles.dart';
import '../../../shared/widgets/bottom_sheet_actions_widget.dart';
import 'user_profile_state.dart';

class ProfileOptionsBottomSheet extends StatelessWidget {
  const ProfileOptionsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BottomSheetActionsContentWidget(actions: [
        ListTile(
          leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_report.svg',
          ),
          title: const Text('Denunciar'),
          onTap: () =>
              Navigator.pop(context, UserProfileSelectedOption.report()),
        ),
        ListTile(
          leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_block.svg',
          ),
          title: const Text('Bloquear'),
          onTap: () =>
              Navigator.pop(context, UserProfileSelectedOption.block()),
        ),
      ]);
}

class ReportUserDialog extends StatelessWidget {
  const ReportUserDialog({Key? key, required this.reason}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();
  final String? reason;

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController(text: reason);

    return AlertDialog(
      title: const Text('Denunciar', style: kTextStyleAlertDialogTitle),
      content: Form(
        key: _formKey,
        child: TextFormField(
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: _controller,
          maxLength: 500,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Informe o motivo de denúncia deste perfil',
            filled: true,
          ),
          validator: (text) =>
              text?.isNotEmpty != true ? 'Por favor informe o motivo' : null,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          child: const Text('Fechar'),
          onPressed: () => Navigator.pop(context),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          child: const Text('Enviar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, _controller.text);
            }
          },
        ),
      ],
    );
  }
}

class UserBlockConfirmationDialog extends StatelessWidget {
  const UserBlockConfirmationDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text(
          'Bloquear usuário',
          style: kTextStyleAlertDialogTitle,
        ),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: const Text('Sim'),
            onPressed: () => Navigator.pop(context, true),
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: const Text('Não'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
}
