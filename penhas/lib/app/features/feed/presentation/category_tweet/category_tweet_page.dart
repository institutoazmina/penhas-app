import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

import 'category_tweet_controller.dart';

class CategoryTweetPage extends StatefulWidget {
  final String title;
  const CategoryTweetPage({
    Key key,
    this.title = "CategoryTweet",
  }) : super(key: key);

  @override
  _CategoryTweetPageState createState() => _CategoryTweetPageState();
}

class _CategoryTweetPageState
    extends ModularState<CategoryTweetPage, CategoryTweetController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  PageProgressState _currentState = PageProgressState.initial;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getCategories();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: PageProgressIndicator(
        progressState: _currentState,
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 20),
                  child: Text(
                    'Selecione uma das categoria:',
                    style: kTextStyleFeedTweetBody,
                  ),
                ),
                Expanded(
                  child: _builderListView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Observer _builderListView() {
    return Observer(
      builder: (_) {
        return ListView.builder(
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final item = controller.categories[index];
              return Observer(builder: (_) {
                return RadioListTile(
                  activeColor: DesignSystemColors.ligthPurple,
                  value: item.id,
                  title: Text(
                    item.label,
                    style: kTextStyleFeedTweetBody,
                  ),
                  groupValue: controller.selectedRadio,
                  selected: item.isSelected,
                  onChanged: (value) => controller.setCategory(value),
                );
              });
            });
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Categoria'),
      backgroundColor: DesignSystemColors.ligthPurple,
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
}
