import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../authentication/presentation/shared/snack_bar_handler.dart';
import 'compose_tweet_controller.dart';

class ComposeTweetPage extends StatefulWidget {
  const ComposeTweetPage({
    super.key,
    this.title = 'Publicar',
    this.showAppBar = false,
    required this.composeTweetController,
  });

  final String title;
  final bool showAppBar;
  final ComposeTweetController composeTweetController;

  @override
  State<ComposeTweetPage> createState() => _ComposeTweetPageState();
}

class _ComposeTweetPageState extends State<ComposeTweetPage>
    with SnackBarHandler {
  final String inputHint = 'Deixe seu comentário';
  final String anonymousHint =
      'Sua publicação é anônima. As usuárias do app podem comentar sua publicação, mas só você pode iniciar uma conversa com elas.';
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;
  ComposeTweetController get controller => widget.composeTweetController;

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
    for (final d in _disposers!) {
      d();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: widget.showAppBar
          ? AppBar(
              title: Text(widget.title),
              backgroundColor: DesignSystemColors.ligthPurple,
              foregroundColor: DesignSystemColors.white,
            )
          : null,
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
                          contextMenuBuilder: (context, editableTextState) {
                            return AdaptiveTextSelectionToolbar.editableText(
                                editableTextState: editableTextState);
                          }),
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
                              return PenhasButton.roundedFilled(
                                onPressed: controller.isEnableCreateButton
                                    ? () =>
                                        controller.createTweetPressed(context)
                                    : null,
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
                      colorFilter: const ColorFilter.mode(
                          DesignSystemColors.darkIndigoThree, BlendMode.srcIn),
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
    }
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
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
