import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/pages/tutorial_page_view_widget.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page_controller.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class StealthModeTutorialPage extends StatefulWidget {
  const StealthModeTutorialPage({Key? key}) : super(key: key);

  @override
  _StealthModeTutorialPageState createState() =>
      _StealthModeTutorialPageState();
}

class _StealthModeTutorialPageState extends ModularState<
    StealthModeTutorialPage, StealthModeTutorialPageController> {
  List<TutorialPageViewWidget> _contentPageView = [];
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
          child: Observer(
            builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: pages(
                      isPermissionGranted:
                          controller.state.locationPermissionGranted,
                    )!,
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
                )
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
        padding: EdgeInsets.zero,
        elevation: 0.0,
        onPressed: () {
          isLastPage ? _dispose() : _nextPage();
        },
        child: Text(
          isLastPage ? 'Entendi' : 'Pr??ximo',
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

  List<Widget>? pages({required bool isPermissionGranted}) {
    return _contentPageView = [
      const TutorialPageViewWidget(
        title: 'Garanta sua privacidade',
        description:
            'Aplique um disfarce de app de signo para esconder o verdadeiro conte??do do PenhaS.\n\nPara entrar no app com o modo modo camuflado ativo, clique no bot??o "Di??rio astrol??gico" para ser direcionada para a tela de login.',
        bodyWidget: Image(
          image: AssetImage(
            'assets/images/stealth_mode_tutorial_image_1/stealth_mode_tutorial_image_1.png',
          ),
          height: 300,
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.topCenter,
        ),
      ),
      const TutorialPageViewWidget(
        title: 'Bot??o de P??nico Disfar??ado',
        description:
            'Em situa????o de emerg??ncia clique e segure no s??mbolo do signo em destaque, at?? que ele troque de cor. Isso enviar?? um alerta para seus guardi??es e durante 15 minutos um ??udio ser?? gravado.',
        bodyWidget: Image(
          image: AssetImage(
            'assets/images/stealth_mode_tutorial_image_2/stealth_mode_tutorial_image_2.png',
          ),
          width: 270,
          height: 270,
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.topCenter,
        ),
      ),
      TutorialPageViewWidget(
        title: 'Habilitar permiss??es',
        description:
            'Para usar todas as fun????es do PenhaS, voc?? precisar?? habilitar permiss??es de acesso ao microfone e ao GPS nas configura????es do seu celular.',
        bodyWidget: Column(
          children: [
            const Image(
              image: AssetImage(
                'assets/images/stealth_mode_tutorial_image_3/stealth_mode_tutorial_image_3.jpg',
              ),
              width: 270,
              height: 270,
              fit: BoxFit.fitWidth,
              alignment: FractionalOffset.center,
            ),
            if (!isPermissionGranted)
              FlatButton(
                onPressed: controller.requestLocationPermission,
                child: const Text(
                  'AUTORIZAR LOCALIZA????O',
                  style: TextStyle(
                    color: DesignSystemColors.pinky,
                    fontFamily: 'Lato',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
      const TutorialPageViewWidget(
        title: 'Feed An??nimo',
        description:
            'Ao habilitar o modo camuflado o seu feed ficar?? an??nimo para manter o seu perfil sigiloso',
        bodyWidget: Image(
          image: AssetImage(
            'assets/images/stealth_mode_tutorial_image_4/stealth_mode_tutorial_image_4.png',
          ),
          width: 270,
          height: 270,
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.topCenter,
        ),
      )
    ];
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
