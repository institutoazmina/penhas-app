import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mastodon_dart/mastodon_dart.dart';
import 'package:url_launcher/url_launcher.dart';

/// [launchUrl] is null if it's not ready.
/// [submitCode] is null if it's not ready.
/// [account] is null if the user is not logged in.
///
/// Usually the page will navigate
typedef AuthWidgetBuilder = Widget Function(
  BuildContext context,
  Function launchUrl,
  void Function(String) submitCode,
  String token,
  Account account,
);

/// Handles browser launching via [launchUrl] builder method.
///
/// Automatically logs in the user if they return with a valid
/// authCode in their clipboard.
///
/// Also accepts authCode via the [submitCode] builder method, which is
/// often wired up to [TextField.onChanged] in a naive fashion.

class AuthBuilder extends StatefulWidget {
  final AuthBloc bloc;

  final AuthWidgetBuilder builder;

  AuthBuilder({
    @required this.bloc,
    @required this.builder,
  });

  @override
  _AuthBuilderState createState() => _AuthBuilderState();
}

class _AuthBuilderState extends State<AuthBuilder> with WidgetsBindingObserver {
  AuthBloc get bloc => widget.bloc;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _handleClipboard();
    }
  }

  _handleLaunchUrl() {
    launch(bloc.uri.value.toString());
  }

  _handleClipboard() async {
    final clipboard = await Clipboard.getData("text/plain");
    _handleSubmitCode(clipboard?.text);
  }

  _handleSubmitCode(String code) {
    bloc.codeSink.add(code);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Uri>(
      stream: bloc.uri,
      initialData: bloc.uri.value,
      builder: (context, uri) => StreamBuilder<Account>(
        stream: bloc.account,
        initialData: bloc.account.value,
        builder: (context, account) => StreamBuilder<String>(
          stream: bloc.token,
          initialData: bloc.token.value,
          builder: (_, token) => widget.builder(
            context,
            uri.hasData ? _handleLaunchUrl : null,
            uri.hasData ? _handleSubmitCode : null,
            token.hasData ? token.data : null,
            account.hasData ? account.data : null,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
