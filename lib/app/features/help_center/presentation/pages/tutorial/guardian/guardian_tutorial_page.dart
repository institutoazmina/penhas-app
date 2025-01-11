import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/pages/tutorial_page_view_widget.dart';
import '../../../../../../shared/design_system/colors.dart';
import '../../../../../../shared/design_system/widgets/buttons/penhas_button.dart';

class GuardianTutorialPage extends StatefulWidget {
  const GuardianTutorialPage({Key? key}) : super(key: key);

  @override
  _GuardianTutorialPageState createState() => _GuardianTutorialPageState();
}

class _GuardianTutorialPageState extends State<GuardianTutorialPage> {
  final List<TutorialPageViewWidget> _contentPageView = [
    TutorialPageViewWidget(
      description:
          'Guardiões são pessoas de sua confiança que você cadastra para te ajudar em situações de perigo.\n\nSeus guardiões não precisam ser usuários do PenhaS, pode ser qualquer pessoa desde que ela aceite o convite que será disparado para o número de telefone dela.',
      bodyWidget: SizedBox(
        height: 270,
        child: SvgPicture.asset(
          'assets/images/svg/tutorial/tutorial_guardian_01.svg',
        ),
      ),
    ),
    const TutorialPageViewWidget(
      description:
          'Use o alerta de guardiões quando estiver em situação de violência. Eles receberão um aviso de que você está em risco com informações da sua localização.',
      bodyWidget: Image(
        image: AssetImage(
          'assets/images/tutorial_guardian_3/tutorial_guardian_3.png',
        ),
        width: 270,
        height: 270,
        fit: BoxFit.fitWidth,
        alignment: FractionalOffset.topCenter,
      ),
    ),
    const TutorialPageViewWidget(
      description:
          'Em situações de emergência, abra o app, clique e segure no símbolo do seu signo para acionar o botão de pânico. Isso enviará um alerta para seus guardiões e durante 15 minutos um áudio será gravado.',
      bodyWidget: Image(
        image: AssetImage(
          'assets/images/tutorial_guardian_2/tutorial_guardian_2.png',
        ),
        width: 250,
        height: 270,
        fit: BoxFit.fitWidth,
        alignment: FractionalOffset.topCenter,
      ),
    ),
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
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
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
                  left: 12.0,
                  right: 12.0,
                  bottom: 12.0,
                ),
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
      width: 145.0,
      child: PenhasButton.roundedFilled(
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
    Navigator.of(context).pop(true);
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
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
