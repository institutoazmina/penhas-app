import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../../shared/design_system/widgets/tags/tags.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../domain/entities/tweet_filter_session_entity.dart';
import 'filter_tweet_controller.dart';

class FilterTweetPage extends StatefulWidget {
  const FilterTweetPage({super.key, required this.controller});

  final FilterTweetController controller;

  @override
  State<FilterTweetPage> createState() => _FilterTweetPageState();
}

class _FilterTweetPageState extends State<FilterTweetPage> with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FilterTweetController get _controller => widget.controller;

  PageProgressState _currentState = PageProgressState.initial;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getTags();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showProgress(),
      _showErrorMessage(),
    ];
  }

  @override
  void dispose() {
    for (final d in _disposers!) {
      d();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Filtrar temas'),
        backgroundColor: DesignSystemColors.ligthPurple,
        foregroundColor: DesignSystemColors.white,
      ),
      body: PageProgressIndicator(
        progressState: _currentState,
        progressMessage: 'Carregando os temas',
        child: SizedBox.expand(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: DesignSystemColors.systemBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 20),
                      child: Text(
                        'Selecione os temas de seu interesse:',
                        style: kTextStyleFeedTweetBody,
                      ),
                    ),
                    Expanded(
                      child: Tags(
                        spacing: 12.0,
                        key: _tagStateKey,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        itemCount: _controller.tags.length,
                        itemBuilder: (int index) {
                          final item = _controller.tags[index];
                          return _builtTagItem(item, index);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildResetPasswordButton(),
                        _buildApplyButton(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Tooltip _builtTagItem(TweetFilterEntity item, int index) {
    return Tooltip(
      message: item.label,
      child: TagItem(
        activeColor: DesignSystemColors.easterPurple,
        title: item.label!,
        index: index,
        active: item.isSelected,
        customData: item.id,
        elevation: 0,
        textStyle: kTextStyleTitleTag,
        textColor: DesignSystemColors.easterPurple,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      ),
    );
  }

  Widget _buildResetPasswordButton() {
    return SizedBox(
      height: 40,
      width: 160,
      child: PenhasButton.text(
        onPressed: () => _controller.reset(),
        child: const Text(
          'Limpar',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: DesignSystemColors.easterPurple,
            decoration: TextDecoration.underline,
            letterSpacing: 0.45,
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      height: 40,
      width: 160,
      child: PenhasButton.roundedFilled(
        onPressed: () => _apply(),
        child: const Text(
          'Aplicar filtro',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.white,
            letterSpacing: 0.45,
          ),
        ),
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => _controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => _controller.currentState,
        (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }

  Future<bool> _apply() {
    if (_tagStateKey.currentState == null) {
      return Future.value(true);
    }

    final List<String> selectedTags = _tagStateKey.currentState?.getAllItem
            .where((e) => e.active)
            .map((e) => e.customData)
            .whereType<String>()
            .toList() ??
        List.empty();

    return _controller.setTags(selectedTags).then((value) => true);
  }
}
