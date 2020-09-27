import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/zodiac/presentation/pages/zodiac_action_button.dart';
import 'package:penhas/app/features/zodiac/presentation/pages/zodiac_felling_page.dart';
import 'package:penhas/app/features/zodiac/presentation/pages/zodiac_rulling_page.dart';
import 'package:penhas/app/features/zodiac/presentation/pages/zodiac_sign_page.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_controller.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ZodiacPage extends StatefulWidget {
  final String title;
  ZodiacPage({
    Key key,
    this.title = "ZodiacPage",
  }) : super(key: key);

  @override
  _ZodiacPageState createState() => _ZodiacPageState();
}

class _ZodiacPageState extends ModularState<ZodiacPage, ZodiacController> {
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder(),
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Container(
              color: Color.fromRGBO(248, 248, 248, 1.0),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Hoje",
                    style: kTextStyleZodiacHoje,
                  ),
                  _buildLoginButton(),
                  Observer(builder: (_) {
                    return ZodiacSignPage(sign: controller.sign);
                  }),
                  ZodiacRullingPage(),
                  Observer(builder: (_) {
                    return ZodiacFellingPage(sign: controller.sign);
                  }),
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
          FlatButton(
            padding: EdgeInsets.zero,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => controller.forwardStealthLogin(),
            child: Text(
              "Diário astrólogico",
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
          Icon(
            DesignSystemLogo.penhasLogo,
            color: Colors.white,
            size: 36,
          ),
          Observer(
            builder: (_) {
              return Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: ZodiacActionButton(
                  sign: controller.sign,
                  listOfSign: controller.signList,
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
