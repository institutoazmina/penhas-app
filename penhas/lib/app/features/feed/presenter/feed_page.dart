import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/feed/presenter/compose_toot/compose_toot_page.dart';
import 'package:penhas/app/features/feed/presenter/widget/reply_toot.dart';
import 'package:penhas/app/features/feed/presenter/widget/single_toot.dart';
import 'package:penhas/app/features/feed/toot_entity.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'feed_controller.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key key, this.title = "Feed"}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  final List<TootEntity> tootList = [
    TootEntity(
        userName: 'Luíza',
        time: '10/01/2020',
        content:
            'Eu demorei cerca de 9 anos para até perceber que estava em <b>relacionamento abusivo</b> e por mais que quisesse, demorei 2 anos para sair da situação em que estava.'),
    TootEntity(
        userName: 'Luíza',
        time: '10/01/2020',
        content:
            'Lorem Ipsum é que nem os comportamentos machistas dentro da criação. Você não presta atenção, só sai reproduzindo por aí. Mas também, pra que levar a sério um texto que não diz nada ou mulheres que são minoria? Afinal, elas somam só 20% da criação. Um número inversamente proporcional a todas as piadas de cunho machista e sexual que elas escutam todos os dias. Sim, todos os dias.'),
    TootEntity(
      userName: 'Luíza',
      time: '10/01/2020',
      content:
          'Sem falar nessa cultura absurda de que quanto mais a pessoa trabalha, mais valorizada é. Em meio a uma sociedade machista e patriarcal, conciliar essa vida de agência com a rotina da casa e a maternidade não é nada fácil.',
      reply: TootEntity(
          userName: 'Anônima',
          time: '02/09/2020',
          content:
              'Respeito e feminismo não são assuntos só pra cases. Tá na hora de repensar suas atitudes. Mudar velhos hábitos não é difícil. Você, por exemplo, acabou de mudar um: leu um Lorem Ipsum pela primeira vez.'),
    ),
    TootEntity(
        userName: 'Joana',
        time: '10/05/2020',
        content:
            'Criação era pra ser um ambiente alegre e diverso. E há quem diga que é. Claro, não dá pra esperar que homens, na sua maioria brancos, heterossexuais, viajados e com padrão elevado de renda entendam que é um lugar bem mais hostil e opressor do que parece. Um ambiente que acaba afastando as mulheres. Por isso, muitas acabam desistindo da criação. E não pense que esse é um ato covarde. Tem que ter muita coragem pra desistir da sua carreira e sonhos por um pouco de amor próprio.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
          onPressed: () => _onFabPressed(context),
          child: SvgPicture.asset(
            'assets/images/svg/bottom_bar/compose_toot.svg',
            color: Colors.white,
          )),
      body: SizedBox.expand(
        child: Container(
          color: Color.fromRGBO(248, 248, 248, 1.0),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 19.0, bottom: 19.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 32.0,
                          width: 140.0,
                          child: RaisedButton(
                            elevation: 0.0,
                            onPressed: () {},
                            color: DesignSystemColors.white,
                            shape: kButtonShapeOutlinePurple,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Categorias',
                                    style: kTextStyleFeedCategoryButtonLabel),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: DesignSystemColors.ligthPurple,
                                  size: 32.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                          width: 160.0,
                          child: RaisedButton(
                            elevation: 0.0,
                            onPressed: () {},
                            color: DesignSystemColors.white,
                            shape: kButtonShapeOutlinePurple,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.filter_list,
                                  color: DesignSystemColors.ligthPurple,
                                  size: 22.0,
                                ),
                                Text('Filtros por temas',
                                    style: kTextStyleFeedCategoryButtonLabel),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemCount: tootList.length,
                        itemBuilder: (context, index) {
                          return tootList[index].reply == null
                              ? SingleToot(
                                  toot: tootList[index],
                                  rootContext: context,
                                )
                              : ReplyToot(toot: tootList[index]);
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildInputToot() {
    return Container(
      height: 90.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 8.0,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          shape: BoxShape.rectangle,
          border: Border.all(color: Color.fromRGBO(216, 216, 216, 1.0)),
        ),
        child: Center(
          child: Text(
            'Gostaria de compartilhar alguma experiência ou história sua?',
            style: kTextStyleFeedTootInput,
          ),
        ),
      ),
    );
  }

  void _onFabPressed(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        // return ComposeTootPage();
        // return Container(
        //   color: Colors.red,
        //   child: Column(
        //     children: <Widget>[
        //       ListTile(
        //         leading:
        //             SvgPicture.asset('assets/images/svg/bottom_bar/chat.svg'),
        //         title: Text('Conversar'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.block),
        //         title: Text('Bloquear'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.report),
        //         title: Text('Reportar'),
        //         onTap: () {},
        //       )
        //     ],
        //   ),
        // );
      },
    );
  }
}
