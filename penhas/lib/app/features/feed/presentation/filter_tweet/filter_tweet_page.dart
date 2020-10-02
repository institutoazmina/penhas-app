import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';
import 'package:penhas/app/features/feed/presentation/filter_tweet/filter_tweet_controller.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class FilterTweetPage extends StatefulWidget {
  FilterTweetPage({Key key}) : super(key: key);

  @override
  _FilterTweetPageState createState() => _FilterTweetPageState();
}

class _FilterTweetPageState
    extends ModularState<FilterTweetPage, FilterTweetController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageProgressState _currentState = PageProgressState.initial;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getTags();
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
    _disposers.forEach((d) => d());
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Filtrar temas'),
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: PageProgressIndicator(
          progressState: _currentState,
          progressMessage: 'Carregando os temas',
          child: SizedBox.expand(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  color: DesignSystemColors.systemBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 4, bottom: 20),
                        child: Text(
                          'Selecione os temas de seu interesse:',
                          style: kTextStyleFeedTweetBody,
                        ),
                      ),
                      Expanded(
                        child: Tags(
                          spacing: 12.0,
                          symmetry: false,
                          key: _tagStateKey,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          itemCount: controller.tags.length,
                          itemBuilder: (int index) {
                            final item = controller.tags[index];
                            return _builtTagItem(item, index);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
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
          )),
    );
  }

  Tooltip _builtTagItem(TweetFilterEntity item, int index) {
    return Tooltip(
        message: item.label,
        child: ItemTags(
          activeColor: DesignSystemColors.easterPurple,
          title: item.label,
          index: index,
          active: item.isSelected,
          customData: item.id,
          elevation: 0,
          textStyle: kTextStyleTitleTag,
          textColor: DesignSystemColors.easterPurple,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
        ));
  }

  Widget _buildResetPasswordButton() {
    return SizedBox(
      height: 40,
      width: 160,
      child: FlatButton(
        onPressed: () => controller.reset(),
        color: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(
          "Limpar",
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
      child: RaisedButton(
        onPressed: () => _apply(),
        elevation: 0,
        color: DesignSystemColors.ligthPurple,
        child: Text("Aplicar filtro",
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.white,
              letterSpacing: 0.45,
            )),
        shape: kButtonShapeOutlinePurple,
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
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

  Future<bool> _apply() {
    if (_tagStateKey.currentState == null) {
      return Future.value(true);
    }

    final seletedTags = _tagStateKey.currentState.getAllItem
        .where((e) => e.active)
        .map((e) => e.customData)
        .map((e) => e as String)
        .toList();

    return controller.setTags(seletedTags).then((value) => true);
  }
}
