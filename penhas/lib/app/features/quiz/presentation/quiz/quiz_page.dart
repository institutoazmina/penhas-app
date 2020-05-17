import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_message_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_user_replay_widget.dart';
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
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Observer(
                  builder: (_) {
                    return ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.only(top: 8.0),
                      itemCount: controller.messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return QuizMessageWidget(
                          message: controller.messages[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Observer(
              builder: (_) {
                return QuizUserReplayWidget(
                    message: controller.userReplyMessage,
                    onActionReplay: controller.onActionReply);
              },
            )
          ],
        ),
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
