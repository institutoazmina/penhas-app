import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_Sign_gemini.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aquarius.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aries.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_cancer.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_capricorn.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_leo.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_pisces.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_sagittarius.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_taurus.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ZodiacPage extends StatefulWidget {
  ZodiacPage({Key key}) : super(key: key);

  @override
  _ZodiacPageState createState() => _ZodiacPageState();
}

class _ZodiacPageState extends State<ZodiacPage> {
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
                    style: kTextStyleFeedTweetReplyHeader,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: Row(
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          elevation: 0,
                          color: Colors.transparent,
                          child: Text(
                            "Diário astrólogico",
                            style: kTextStyleFeedTweetShowReply,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ZodiacSignCancer().constelation,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(
                      ZodiacSignCancer().name,
                      style: kTextStyleZodiacTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      ZodiacSignCancer().date,
                      style: kTextStyleGuardianBodyTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                'assets/images/zodiac/svg/sun.svg'),
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Text('Sol'),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                'assets/images/zodiac/svg/moon.svg'),
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Text(
                                'Lua',
                                style: kTextStyleZodiacRulling,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                'assets/images/zodiac/svg/venus.svg'),
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Text(
                                'Vênus',
                                style: kTextStyleZodiacRulling,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Tags(
                      spacing: 8.0,
                      symmetry: false,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      itemCount: 5,
                      itemBuilder: (int index) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: DesignSystemColors.easterPurple,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Amor',
                            style: kTextStyleZodiacFelling,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Container(
              height: 44.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZodiacSignAquarius().icone,
                  ZodiacSignAries().icone,
                  ZodiacSignCapricorn().icone,
                  ZodiacSignGemini().icone,
                  FlatButton(
                    child: ZodiacSignCancer().icone,
                    onPressed: () {},
                    color: DesignSystemColors.bluishPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  ZodiacSignPisces().icone,
                  ZodiacSignLeo().icone,
                  ZodiacSignSagittarius().icone,
                  ZodiacSignTaurus().icone,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
