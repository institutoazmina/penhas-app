import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/colors.dart';
import '../../domain/entity/contact.dart';
import 'edit_trusted_contacts_controller.dart';
import 'edit_trusted_contacts_dialogs.dart';
import 'edit_trusted_contacts_state.dart';

typedef OnContactActionPressed = void Function(ContactEntity contact);

class EditTrustedContactsPage extends StatefulWidget {
  const EditTrustedContactsPage({Key? key, required this.controller})
      : super(key: key);

  final EditTrustedContactsController controller;

  @override
  State<EditTrustedContactsPage> createState() =>
      _EditTrustedContactsPageState();
}

class _EditTrustedContactsPageState extends State<EditTrustedContactsPage> {
  ReactionDisposer? _disposer;

  EditTrustedContactsController get controller => widget.controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposer ??= controller.onReaction(_onReaction);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        Timer.run(() => Modular.to.pop(controller.contacts));
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar'),
          elevation: 0,
          backgroundColor: DesignSystemColors.easterPurple,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                child: Text(
                  'Contatos de confiança',
                  style: textTheme.titleLarge?.copyWith(
                    color: DesignSystemColors.darkIndigoThree,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                child: Text(
                  'Adicione os contatos de até três pessoas que você possa '
                  'acionar em um momento de emergência. É importante ser '
                  'alguém que você confia, seja um amigo ou familiar mais '
                  'próximo, e que essa pessoa saiba previamente da sua '
                  'situação.',
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: DesignSystemColors.darkIndigoThree,
                  ),
                ),
              ),
              Observer(
                builder: (_) => controller.state.when(
                  loaded: (contacts) => _LoadedStateWidget(
                    contacts: contacts,
                    onUpdateContactPressed: controller.onUpdateContactPressed,
                    onRemoveContactPressed: controller.onRemoveContactPressed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onReaction(EditTrustedContactsReaction? reaction) {
    reaction?.when(
      requestContactInfo: _onRequestContactInfo,
      askForDeleteConfirmation: _onAskForDeleteConfirmation,
    );
  }

  void _onRequestContactInfo(ContactEntity contact) async {
    final updated = await showDialog<ContactEntity>(
      context: context,
      builder: (_) => UpdateContactDialog(contact),
      useRootNavigator: false,
    );

    if (updated != null) {
      controller.updateContact(updated);
    }
  }

  void _onAskForDeleteConfirmation(ContactEntity contact) async {
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (_) => RemoveContactConfirmationDialog(contact),
      useRootNavigator: false,
    );

    if (shouldRemove == true) {
      controller.removeContact(contact);
    }
  }
}

class _LoadedStateWidget extends StatelessWidget {
  const _LoadedStateWidget({
    Key? key,
    required this.contacts,
    required this.onUpdateContactPressed,
    required this.onRemoveContactPressed,
  }) : super(key: key);

  final List<ContactEntity> contacts;
  final OnContactActionPressed onUpdateContactPressed;
  final OnContactActionPressed onRemoveContactPressed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: contacts.length,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      itemBuilder: (_, index) {
        final contact = contacts[index];
        return _ContactCard(
          key: Key('trusted-contact_${contact.id}'),
          contact: contact,
          onUpdatePressed: () => onUpdateContactPressed(contact),
          onRemovePressed: () => onRemoveContactPressed(contact),
        );
      },
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    Key? key,
    required this.contact,
    required this.onUpdatePressed,
    required this.onRemovePressed,
  }) : super(key: key);

  final ContactEntity contact;
  final VoidCallback onUpdatePressed;
  final VoidCallback onRemovePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: ShapeDecoration(
        color: DesignSystemColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadows: const [
          BoxShadow(
            color: DesignSystemColors.shadowColor,
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 3),
        contentPadding: const EdgeInsets.only(left: 16, right: 8),
        title: Text(
          contact.name,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            color: DesignSystemColors.darkIndigoThree,
          ),
        ),
        subtitle: Text(
          contact.phone,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            color: DesignSystemColors.blueyGrey,
          ),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Editar',
              onPressed: onUpdatePressed,
              icon: SvgPicture.asset(
                'assets/images/svg/actions/edit.svg',
                colorFilter: const ColorFilter.mode(
                    DesignSystemColors.pumpkinOrange, BlendMode.color),
                height: theme.iconTheme.size,
                width: theme.iconTheme.size,
              ),
            ),
            IconButton(
              tooltip: 'Remover',
              onPressed: onRemovePressed,
              icon: SvgPicture.asset(
                'assets/images/svg/actions/close.svg',
                colorFilter: const ColorFilter.mode(
                    DesignSystemColors.pumpkinOrange, BlendMode.color),
                height: theme.iconTheme.size,
                width: theme.iconTheme.size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
