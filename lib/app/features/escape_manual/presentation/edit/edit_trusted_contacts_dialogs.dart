import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../domain/entity/contact.dart';

class RemoveContactConfirmationDialog extends StatelessWidget {
  const RemoveContactConfirmationDialog(
    this.contact, {
    Key? key,
  }) : super(key: key);

  final ContactEntity contact;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Remover contato',
        style: kTextStyleAlertDialogTitle,
      ),
      actionsPadding: const EdgeInsets.only(right: 16, bottom: 8),
      content: Text(
        'Tem certeza que deseja remover o contato "${contact.name}"?',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: <Widget>[
        _SecondaryButton(
          text: 'Sim',
          onPressed: () => Navigator.pop(context, true),
        ),
        _PrimaryButton(
          text: 'Não',
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}

class UpdateContactDialog extends StatefulWidget {
  const UpdateContactDialog(
    this.contact, {
    Key? key,
  }) : super(key: key);

  final ContactEntity contact;

  @override
  State<UpdateContactDialog> createState() => _UpdateContactDialogState();
}

class _UpdateContactDialogState extends State<UpdateContactDialog> {
  final _formKey = GlobalKey<FormState>(
    debugLabel: 'update-contact-form-key',
  );

  late final _nameController = TextEditingController(text: widget.contact.name);
  late final _phoneController =
      TextEditingController(text: widget.contact.phone);

  @override
  Widget build(BuildContext context) {
    final title =
        widget.contact.name.isEmpty ? 'Adicionar contato' : 'Alterar contato';
    return AlertDialog(
      title: Text(title, style: kTextStyleAlertDialogTitle),
      actionsPadding: const EdgeInsets.only(right: 16, bottom: 8),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              key: const Key('contact-name-field'),
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textInputAction: TextInputAction.next,
              controller: _nameController,
              keyboardType: TextInputType.name,
              maxLength: contactNameMaxLength,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Nome',
                counterText: '',
              ),
              validator: (text) =>
                  text?.isNotEmpty != true ? 'Por favor informe o nome' : null,
            ),
            TextFormField(
              key: const Key('contact-phone-field'),
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              controller: _phoneController,
              maxLength: contactPhoneMaxLength,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                counterText: '',
              ),
              validator: (text) => text?.isNotEmpty != true
                  ? 'Por favor informe o telefone'
                  : null,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: <Widget>[
        _SecondaryButton(
          text: 'Fechar',
          onPressed: () => Navigator.pop(context),
        ),
        _PrimaryButton(
          text: 'Salvar',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(
                context,
                widget.contact.copyWith(
                  name: _nameController.text,
                  phone: _phoneController.text,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      child: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: DesignSystemColors.ligthPurple,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        minimumSize: const Size(88.0, 36.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          side: BorderSide(color: DesignSystemColors.ligthPurple),
        ),
        textStyle: theme.textTheme.labelLarge?.copyWith(
          fontSize: 15,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          color: DesignSystemColors.white,
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: const Color(0xFF8D929D),
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        minimumSize: const Size(88.0, 36.0),
        textStyle: theme.textTheme.labelLarge?.copyWith(
          fontSize: 15,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
