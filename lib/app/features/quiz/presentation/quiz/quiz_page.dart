import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/colors.dart';
import 'quiz_controller.dart';
import 'quiz_message_widget.dart';
import 'quiz_user_replay_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, this.title = 'Quiz'}) : super(key: key);

  final String title;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends ModularState<QuizPage, QuizController> {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String? message) {
        if (message!.isEmpty) {
          return;
        }

        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: DesignSystemColors.white,
                child: Observer(
                  builder: (_) {
                    return ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.only(top: 8.0),
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
                final message = controller.userReplyMessage;
                if (message == null) return Container();

                return QuizUserReplayWidget(
                  message: message,
                  onActionReplay: controller.onActionReply,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final d in _disposers!) {
      d();
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: DesignSystemColors.ligthPurple,
      title: const Center(
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
