import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'quiz_controller.dart';

class QuizPage extends StatefulWidget {
  final String title;
  const QuizPage({Key key, this.title = "Quiz"}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends ModularState<QuizPage, QuizController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: DesignSystemColors.ligthPurple,
      title: Center(
        child: SizedBox(
          width: 39.0,
          height: 18.0,
          child: Image(
            image: AssetImage('assets/images/penhas_symbol/penhas_symbol.png'),
          ),
        ),
      ),
    );
  }
}
