import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:mobx/mobx.dart';

import '../../../core/extension/asuka.dart';
import '../../../shared/design_system/button_shape.dart';
import '../../../shared/design_system/colors.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../mainboard/presentation/mainboard/mainboard_page.dart';
import '../domain/entities/user_detail_entity.dart';
import '../domain/entities/user_detail_profile_entity.dart';
import 'user_profile_controller.dart';
import 'user_profile_dialogs.dart';
import 'user_profile_state.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final UserProfileController controller;

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SnackBarHandler {
  ReactionDisposer? _disposer;
  late final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final _progressDialogKey = GlobalKey();

  UserProfileController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _disposer = reaction((_) => controller.reaction, _handleReaction);
  }

  @override
  void dispose() {
    _disposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: DesignSystemColors.systemBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignSystemColors.easterPurple,
        actions: [
          Observer(
            builder: (_) => _buildMenuAction(controller.menuState),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) => bodyBuilder(controller.state),
        ),
      ),
    );
  }
}

extension _UserProfilePagePrivate on _UserProfilePageState {
  Widget bodyBuilder(UserProfileState state) {
    return state.when(
      initial: () => empty(),
      loaded: (user) => loaded(user),
      error: (message) => empty(),
    );
  }

  Widget _buildMenuAction(UserMenuState state) => state.when(
        visible: () => IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: controller.onTapMenuOptions,
        ),
        hidden: () => Container(),
      );

  void _handleReaction(UserProfileReaction? reaction) {
    reaction?.when(
      showProfileOptions: _showProfileOptions,
      showBlockConfirmationDialog: _showBlockConfirmationDialog,
      askReportReasonDialog: _askReportReasonDialog,
      showProgressDialog: _showProgressDialog,
      dismissProgressDialog: _dismissProgressDialog,
      showSnackBar: _showSnackBar,
    );
  }

  Widget empty() => Container(color: DesignSystemColors.systemBackgroundColor);

  Widget loaded(UserDetailEntity user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildHeader(user.profile),
        buildContent(user.profile),
        if (!user.isMyself)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 70.0,
              vertical: 20.0,
            ),
            child: SizedBox(
              height: 44,
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () => controller.openChannel(),
                elevation: 0,
                color: DesignSystemColors.ligthPurple,
                shape: kButtonShapeFilled,
                child: Text(
                  'Conversar',
                  style: buttonTitleStyle,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildHeader(UserDetailProfileEntity user) {
    return Container(
      color: DesignSystemColors.easterPurple,
      height: 120,
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white38,
            child: user.avatar == null || user.avatar!.isEmpty
                ? Container()
                : SvgPicture.network(user.avatar!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              user.nickname!,
              style: nameStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget buildContent(UserDetailProfileEntity user) {
    final List<String> skills = user.skills!.split(',');
    skills.removeWhere((e) => e.isEmpty);

    return Container(
      color: DesignSystemColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text('Minibio', style: headerStyle),
            ),
            Text(
              user.miniBio ?? '',
              style: bodyStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text('Disponível para falar sobre', style: headerStyle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Tags(
                spacing: 12,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                itemCount: skills.length,
                itemBuilder: (int index) {
                  final item = skills[index];
                  return builtTagItem(item, index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Tooltip builtTagItem(String item, int index) {
    return Tooltip(
      message: item,
      child: ItemTags(
        activeColor: DesignSystemColors.easterPurple,
        color: DesignSystemColors.easterPurple,
        title: item,
        index: index,
        elevation: 0,
        textStyle: tagStyle,
        textColor: DesignSystemColors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      ),
    );
  }

  void _showProfileOptions() async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (_) => const ProfileOptionsBottomSheet(),
    );

    controller.onOptionSelected(result);
  }

  void _askReportReasonDialog(String? initialReason) async {
    final reason = await Modular.to.showDialog(
      builder: (_) => ReportUserDialog(reason: initialReason),
    );

    if (reason != null) {
      controller.onSendReportPressed(reason);
    }
  }

  void _showBlockConfirmationDialog(String message) async {
    final confirm = await Modular.to.showDialog(
      builder: (_) => UserBlockConfirmationDialog(message: message),
    );

    if (confirm == true) {
      controller.onConfirmBlockPressed();
    }
  }

  void _showProgressDialog() {
    Modular.to.showDialog(
      barrierDismissible: false,
      builder: (_) => PageProgressIndicator(
        key: _progressDialogKey,
        progressState: PageProgressState.loading,
        child: Container(color: Colors.transparent),
      ),
    );
  }

  void _dismissProgressDialog() {
    final context = _progressDialogKey.currentContext;
    if (context == null) return;
    Navigator.pop(context);
  }

  void _showSnackBar(String message, bool inMainboardPage) {
    _dismissProgressDialog();
    showSnackBar(
      scaffoldKey: inMainboardPage ? MainboardPage.mainBoardKey : _scaffoldKey,
      message: message,
    );
  }

  TextStyle get nameStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get headerStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );

  TextStyle get bodyStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        height: 1.2,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );

  TextStyle get tagStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.normal,
      );

  TextStyle get buttonTitleStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.bold,
      );
}
