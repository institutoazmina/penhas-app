import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../shared/design_system/colors.dart';
import '../../../shared/design_system/logo.dart';
import '../../../shared/design_system/text_styles.dart';
import 'pages/zodiac_action_button.dart';
import 'pages/zodiac_felling_page.dart';
import 'pages/zodiac_ruling_page.dart';
import 'pages/zodiac_sign_page.dart';
import 'zodiac_controller.dart';

class ZodiacPage extends StatefulWidget {
  const ZodiacPage({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final ZodiacController controller;

  @override
  State<ZodiacPage> createState() => _ZodiacPageState();
}

class _ZodiacPageState extends State<ZodiacPage> {
  ZodiacController get controller => widget.controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder() as PreferredSizeWidget,
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Container(
              color: DesignSystemColors.systemBackgroundColor,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Hoje',
                    style: kTextStyleZodiacHoje,
                  ),
                  _buildLoginButton(),
                  Observer(
                    name: 'ZodiacPage.build.ZodiacSignPage',
                    builder: (_) {
                      return ZodiacSignPage(sign: controller.sign);
                    },
                  ),
                  const ZodiacRulingPage(),
                  Observer(
                    name: 'ZodiacPage.build.ZodiacFellingPage',
                    builder: (_) {
                      return ZodiacFellingPage(sign: controller.sign);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 44.0,
      child: Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () => controller.forwardStealthLogin(),
            child: const Text(
              'Diário astrológico',
              style: kTextStyleFeedTweetShowReply,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBarBuilder() {
    return AppBar(
      elevation: 0.0,
      toolbarHeight: 120,
      centerTitle: true,
      backgroundColor: DesignSystemColors.easterPurple,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            DesignSystemLogo.penhasLogo,
            color: Colors.white,
            size: 36,
          ),
          Observer(
            name: 'ZodiacPage.appBarBuilder',
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ZodiacActionButton(
                  sign: controller.sign,
                  listOfSign: controller.signList,
                  isRunning: controller.isSecurityRunning,
                  onPressed: () => controller.stealthAction(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
