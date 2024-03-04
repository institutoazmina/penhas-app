import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:scroll_to_index/util.dart';

import '../../../../core/extension/animated_list.dart';
import '../../../../core/extension/list.dart';
import '../../../../core/extension/scroll_controller.dart';
import '../../../../shared/design_system/colors.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/answer.dart';
import '../../domain/entities/quiz_message.dart';
import 'messages/_message.dart';
import 'quiz_controller.dart';

const fabScrollOffset = 48.0;

class NewQuizPage extends StatelessWidget {
  const NewQuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DesignSystemColors.ligthPurple,
        centerTitle: true,
        title: const SizedBox(
          width: 39,
          height: 18,
          child: Image(
            image: AssetImage(
              'assets/images/penhas_symbol/penhas_symbol.png',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (_, constraints) {
          return QuizContent(
            constraints: constraints,
          );
        }),
      ),
    );
  }
}

class QuizContent extends StatefulWidget {
  const QuizContent({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  static QuizContentState? of(BuildContext context) =>
      context.findAncestorStateOfType<QuizContentState>();

  @override
  State<QuizContent> createState() => QuizContentState();
}

class QuizContentState extends ModularState<QuizContent, IQuizController>
    with TickerProviderStateMixin<QuizContent>
    implements ScrollOverflowListener {
  final _listKey = GlobalKey<SliverAnimatedListState>();

  @override
  SliverGeometry? get renderGeometry => _listKey.renderGeometry;

  late final _scrollController = ScrollController();
  late final _animationController =
      AnimationController(value: 1, duration: animationDuration, vsync: this)
        ..addListener(_updateWidgetState);

  Duration get animationDuration => controller.animationDuration;

  late final List<QuizMessage> _currentMessages = controller.messages.toList();

  List<ReactionDisposer>? _disposer;

  bool _hasPendingMessages = false;
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _disposer ??= [_listenToMessagesUpdates(), _listenToErrorMessage()];
    _scrollController.scrollToEnd(animationDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAnimatedList(
            key: _listKey,
            initialItemCount: _currentMessages.length,
            itemBuilder: (_, index, animation) {
              final message = _currentMessages.elementAtOrNull(index);

              // coverage:ignore-start
              if (message == null) {
                // prevent possible crashs when message is not found
                logError('Message not found: index=$index');
                return const SizedBox.shrink();
              }
              // coverage:ignore-end

              return AnimatedMessage(
                index: index,
                message: message,
                animation: animation,
              );
            },
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                const SizedBox(height: 8.0),
                InteractionBox(
                  animation: _animationController.view,
                  message: controller.interactiveMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedSlide(
        duration: animationDuration,
        offset: _showFab ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: animationDuration,
          opacity: _showFab ? 1 : 0,
          child: FloatingActionButton(
            onPressed: _onFabTap,
            backgroundColor: DesignSystemColors.ligthPurple,
            child: const Icon(
              Icons.arrow_downward,
              semanticLabel: 'Ir para o final da conversa',
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposer?.forEach((d) => d());
    _disposer = null;
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void onReply(UserAnswer reply) async {
    await _hideInteractiveMessage();
    controller.onReplyMessage(reply);
  }

  void onRetry(UserAnswer reply) async {
    controller.onReplyMessage(reply);
  }

  @override
  void onScrollOverflow() {
    _maybeShowFab();
  }

  /// Helper to request the screen to update the widget state
  void _updateWidgetState([VoidCallback? callback]) {
    setState(callback ?? () {});
  }
}

extension _QuizContentStateHelpers on QuizContentState {
  /// Update the list with new messages
  /// It will add new messages sequentially and smoothly
  Future<void> _updateList(List<QuizMessage> newMessages) async {
    final initialRenderGeometry = _listKey.renderGeometry;
    // prevent fab from showing while updating the list
    _hasPendingMessages = true;

    for (var index = 0; index < newMessages.length; index++) {
      await _addOrUpdateMessage(
        index,
        newMessages[index],
        initialRenderGeometry,
      );
    }

    _hasPendingMessages = false;
    _showInteractiveMessage();

    // smooth scroll to display the interactive message
    _scrollController.maybeScrollToEnd(
      this,
      initialRenderGeometry,
      animationDuration,
    );
  }

  /// Add or update the message at the given index.
  /// Only if is an insertion, the animation will be executed
  /// It will scroll to the end of the list to show the new message
  /// depending on the [initialRenderGeometry]
  Future<void> _addOrUpdateMessage(
    int index,
    QuizMessage newMessage,
    SliverGeometry? initialRenderGeometry,
  ) async {
    final oldMessage = _currentMessages.elementAtOrNull(index);
    if (oldMessage != null) {
      _currentMessages[index] = newMessage;
      return;
    }

    _currentMessages.add(newMessage);
    _listKey.currentState?.insertItem(index, duration: animationDuration);
    await controller.waitAnimationCompletion();

    // smooth scroll to show each new message
    _scrollController.maybeScrollToEnd(
      this,
      initialRenderGeometry,
      animationDuration,
    );
  }

  void _onFabTap() {
    _scrollController.scrollToEnd(animationDuration);
  }

  /// Show the FAB only if the list is not at the end
  void _maybeShowFab() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;
    final showFab = maxScrollExtent - offset > fabScrollOffset;
    if (showFab != _showFab) {
      _updateWidgetState(() {
        _showFab = showFab;
      });
    }
  }

  /// Show the interactive message with a smooth animation
  /// It will notify the screen to InteractionBox show the new message
  void _showInteractiveMessage() async {
    _updateWidgetState();
    _animationController.forward();
    await controller.waitAnimationCompletion();
  }

  /// Hide the interactive message with a smooth animation
  /// It will prepare to remove the interactive message from the screen
  Future<void> _hideInteractiveMessage() async {
    _animationController.reverse();
    // wait for the hide interactive message animation
    await controller.waitAnimationCompletion();
  }

  /// listen to the scroll updates to show/hide
  /// the FAB only when has no pending messages
  void _scrollListener() {
    if (_hasPendingMessages) return;
    WidgetsBinding.instance?.addPostFrameCallback((_) => _maybeShowFab());
  }

  /// Dispatch the message updates to the list
  /// Preventing concurrent updates to allow smooth the list updates
  ReactionDisposer _listenToMessagesUpdates() => reaction<List<QuizMessage>>(
        (_) => controller.messages,
        (newMessages) => co(
          controller,
          () async => _updateList(newMessages),
        ),
        equals: const ListEquality().equals,
        onError: (error, _) => logError(error), // coverage:ignore-line
      );

  /// Listen to error messages to show a snackbar
  /// with the error message
  ReactionDisposer _listenToErrorMessage() => reaction<String?>(
        (_) => controller.errorMessage,
        (message) {
          if (message == null || message.isEmpty) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
      );
}
