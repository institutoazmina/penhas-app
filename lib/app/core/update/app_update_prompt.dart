import 'dart:async';

import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

import '../../shared/design_system/text_styles.dart';
import '../../shared/logger/log.dart';
import 'app_update_checker.dart';
import 'app_update_launcher.dart';

class AppUpdatePrompt extends StatefulWidget {
  const AppUpdatePrompt({
    super.key,
    required this.checker,
    required this.launcher,
    required this.child,
  });

  final AppUpdateChecker checker;
  final AppUpdateLauncher launcher;
  final Widget child;

  @override
  State<AppUpdatePrompt> createState() => _AppUpdatePromptState();
}

class _AppUpdatePromptState extends State<AppUpdatePrompt> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_checkForUpdate());
    });
  }

  Future<void> _checkForUpdate() async {
    try {
      if (!await widget.checker.shouldPrompt() || !mounted) return;

      await Asuka.showDialog<void>(
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text(
            'Atualização disponível',
            style: kTextStyleAlertDialogTitle,
          ),
          content: const Text(
            'Uma nova versão do PenhaS está disponível. Atualize agora para '
            'receber melhorias de segurança e funcionamento.',
            style: kTextStyleAlertDialogDescription,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Continuar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                unawaited(widget.launcher.launch());
              },
              child: const Text('Atualizar agora'),
            ),
          ],
        ),
      );
    } catch (error, stack) {
      logError(error, stack);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
