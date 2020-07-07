import 'package:flutter/material.dart';
import 'package:penhas/app/core/pages/tutorial_page_view_widget.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class RecordTutorialPage extends StatefulWidget {
  RecordTutorialPage({Key key}) : super(key: key);

  @override
  _RecordTutorialPageState createState() => _RecordTutorialPageState();
}

class _RecordTutorialPageState extends State<RecordTutorialPage> {
  List<TutorialPageViewWidget> _contentPageView = [
    TutorialPageViewWidget(
      description:
          'Coleta de provas é um passo essencial para sair de uma situação de violência. Por isso, com o PenhaS você pode gravar áudios que sirvam de provas contra o agressor.',
      bodyWidget: Image(
        image:
            AssetImage('assets/images/tutorial_record_1/tutorial_record_1.png'),
        width: 270,
        fit: BoxFit.fitWidth,
        alignment: FractionalOffset.topCenter,
      ),
    ),
    TutorialPageViewWidget(
      description:
          'As gravações ficam salvas em ambiente seguro e você poder acessá-las a qualquer momento em "Minhas gravações".',
      bodyWidget: Image(
          image: AssetImage(
              'assets/images/tutorial_record_2/tutorial_record_2.png'),
          width: 270,
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.bottomCenter),
    ),
    TutorialPageViewWidget(
      description:
          'Use o alerta de guardiões quando estiver em situação de violência. Eles receberão um aviso de que você está em risco com informações da sua localização.',
      bodyWidget: Image(
        image:
            AssetImage('assets/images/tutorial_record_3/tutorial_record_3.png'),
        width: 270,
        fit: BoxFit.fitWidth,
        alignment: FractionalOffset.topCenter,
      ),
    ),
    TutorialPageViewWidget(
      description:
          'Os áudios gravados no acionamento do botão de pânico ficam disponíveis em "Minhas gravações". Quando estiver segura, decida entre salvar ou descartar essas gravações.',
      bodyWidget: Image(
        image:
            AssetImage('assets/images/tutorial_record_4/tutorial_record_4.png'),
        width: 270,
        fit: BoxFit.fitWidth,
        alignment: FractionalOffset.topCenter,
      ),
    )
  ];
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignSystemColors.charcoalGrey,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 460,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    children: _contentPageView,
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: _buildPageIndicator()),
                      Row(children: <Widget>[_buildActionButton()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildActionButton() {
    final bool isLastPage = _currentPage == (_contentPageView.length - 1);
    return SizedBox(
      height: 40.0,
      width: 145.0,
      child: RaisedButton(
        color: DesignSystemColors.ligthPurple,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(0.0),
        elevation: 0.0,
        onPressed: () {
          isLastPage ? _dispose() : _nextPage();
        },
        child: Text(
          isLastPage ? "Obrigado" : "Próximo",
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.57,
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _dispose() {
    Navigator.of(context).pop();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _contentPageView.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }

    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 24.0 : 10.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : DesignSystemColors.blueyGrey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
