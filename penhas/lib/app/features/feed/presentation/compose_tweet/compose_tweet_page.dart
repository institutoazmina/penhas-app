import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_controller.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ComposeTweetPage extends StatefulWidget {
  final String title;
  const ComposeTweetPage({Key? key, this.title = "ComposeTweet"})
      : super(key: key);

  final String title;

  @override
  _ComposeTweetPageState createState() => _ComposeTweetPageState();
}

class _ComposeTweetPageState
    extends ModularState<ComposeTweetPage, ComposeTweetController>
    with SnackBarHandler {
  final String inputHint = 'Deixe seu comentário';
  final String anonymousHint =
      'Sua publicação é anônima. As usuárias do app podem comentar sua publicação, mas só você pode iniciar uma conversa com elas.';
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  TextStyle get _kTextStyleNewTweetAnonymousHint => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        letterSpacing: 0.38,
        color: DesignSystemColors.warnGrey,
        fontWeight: FontWeight.normal,
      );

  TextStyle get _kTextStyleNewTweetAnonymous => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.44,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showErrorMessage(),
      _showProgress(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _disposers!.forEach((d) => d());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox.expand(
        child: Container(
          color: DesignSystemColors.systemBackgroundColor,
          child: PageProgressIndicator(
            progressState: _currentState,
            child: GestureDetector(
              onTap: () => _handleTap(context),
              onPanDown: (_) => _handleTap(context),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: controller.editingController,
                        maxLength: 2200,
                        maxLines: 10,
                        onChanged: controller.setTweetContent,
                        decoration: InputDecoration(
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: DesignSystemColors.ligthPurple,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: DesignSystemColors.ligthPurple,
                              width: 2.0,
                            ),
                          ),
                          alignLabelWithHint: true,
                          counterText: '',
                          hintText: inputHint,
                        ),
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          cut: true,
                          selectAll: true,
                          paste: true,
                        ),
                      ),
                      Observer(
                        builder: (context) {
                          return Visibility(
                            visible: controller.isAnonymousMode,
                            replacement: const SizedBox(height: 20.0),
                            child: _buildAnonymousWarning(),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SizedBox(
                          height: 40,
                          width: 220,
                          child: Observer(
                            builder: (_) {
                              return RaisedButton(
                                onPressed: controller.isEnableCreateButton
                                    ? () => controller.createTweetPressed()
                                    : null,
                                elevation: 0.0,
                                shape: kButtonShapeFilled,
                                color: DesignSystemColors.ligthPurple,
                                child: const Text(
                                  'Publicar',
                                  style: kTextStyleDefaultFilledButtonLabel,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildAnonymousWarning() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        decoration: _buildInputTextBoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Text(
                anonymousHint,
                style: _kTextStyleNewTweetAnonymousHint,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/svg/drawer/user_profile.svg',
                      color: DesignSystemColors.darkIndigoThree,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Anônima',
                        style: _kTextStyleNewTweetAnonymous,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildInputTextBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  void _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
<<<<<<< HEAD
    }
=======
>>>>>>> Fix code syntax
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.currentState, (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }
}
