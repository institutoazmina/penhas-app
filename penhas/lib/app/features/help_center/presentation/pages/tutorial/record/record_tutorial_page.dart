import 'package:flutter/material.dart';
import 'package:penhas/app/core/pages/tutorial_page_view_widget.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class RecordTutorialPage extends StatefulWidget {
  const RecordTutorialPage({Key? key}) : super(key: key);

  @override
  _RecordTutorialPageState createState() => _RecordTutorialPageState();
}

class _RecordTutorialPageState extends State<RecordTutorialPage> {
  final List<TutorialPageViewWidget> _contentPageView = [
    const TutorialPageViewWidget(
      description:
          'Para iniciar uma gravação, basta pressionar o botão "Gravar Áudio” e o app já estará gravando o som ambiente. Para encerrar a gravação basta clicar no contador.',
      bodyWidget: Image(
        image:
            AssetImage('assets/images/tutorial_record_1/tutorial_record_1.png'),
        width: 270,
        height: 300,
        fit: BoxFit.fitWidth,
        alignment: FractionalOffset.topCenter,
      ),
    ),
    const TutorialPageViewWidget(
      description:
          'As gravações ficam salvas em ambiente seguro e você poder acessá-las a qualquer momento em "Minhas gravações".',
      bodyWidget: Image(
          image: AssetImage(
              'assets/images/tutorial_record_2/tutorial_record_2.png',),
          width: 270,
          height: 300,
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.bottomCenter,),
    ),
    const TutorialPageViewWidget(
      description:
          'Se estiver com modo camuflado ativo e se encontrar em situação de emergência, abra app, clique e segure no símbolo roxo de signo em destaque, até que ele troque de cor. Isso enviará um alerta para seus guardiões e durante 15 minutos um áudio será gravado.',
      bodyWidget: Image(
        image:
            AssetImage('assets/images/tutorial_guardian_2/tutorial_guardian_2.png'),
        width: 270,
        height: 300,
        fit: BoxFit.fitWidth,
        alignment: FractionalOffset.topCenter,
      ),
    ),
    const TutorialPageViewWidget(
      description:
          'Os áudios gravados ficam disponíveis em “Minhas gravações”. Uma gravação pode ser descartada a qualquer momento através da opção “Apagar”.',
      bodyWidget: Image(
        image:
            AssetImage('assets/images/tutorial_record_4/tutorial_record_4.png'),
        width: 270,
        height: 300,
        fit: BoxFit.fitHeight,
        alignment: FractionalOffset.topCenter,
      ),
    )
  ];
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignSystemColors.charcoalGrey,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: _contentPageView,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 12.0,),
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
        padding: const EdgeInsets.all(0.0),
        elevation: 0.0,
        onPressed: () {
          isLastPage ? _dispose() : _nextPage();
        },
        child: Text(
          isLastPage ? 'Entendi' : 'Próximo',
          style: const TextStyle(
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
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _dispose() {
    Navigator.of(context).pop();
  }

  List<Widget> _buildPageIndicator() {
    final List<Widget> list = [];
    for (int i = 0; i < _contentPageView.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }

    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 24.0 : 10.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : DesignSystemColors.blueyGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),),
    );
  }
}
