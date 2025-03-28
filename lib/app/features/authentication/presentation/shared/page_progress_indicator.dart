import 'package:flutter/material.dart';

enum PageProgressState { initial, loading, loaded }

class PageProgressIndicator extends StatefulWidget {
  const PageProgressIndicator({
    super.key,
    required this.child,
    required this.progressState,
    this.progressMessage = 'Processando',
  });

  final Widget child;
  final PageProgressState progressState;
  final String progressMessage;

  @override
  State<PageProgressIndicator> createState() => _PageProgressIndicatorState();
}

class _PageProgressIndicatorState extends State<PageProgressIndicator>
    with SingleTickerProviderStateMixin {
  _PageProgressIndicatorState();

  late AnimationController _controller;
  late Animation<double> _animation;
  late bool _isProgressVisible;
  final Color _backgroundColor = Colors.black45;

  @override
  void initState() {
    super.initState();

    _isProgressVisible = false;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 20),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() => _isProgressVisible = true);
      } else if (status == AnimationStatus.dismissed) {
        setState(() => _isProgressVisible = false);
      }
    });

    if (_isVisible(widget.progressState)) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(PageProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isVisible(oldWidget.progressState) &&
        _isVisible(widget.progressState)) {
      _controller.forward();
    }

    if (_isVisible(oldWidget.progressState) &&
        !_isVisible(widget.progressState)) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = <Widget>[];
    widgets.add(widget.child);

    if (_isProgressVisible) {
      widgets.add(_buildFadeTransition());
      widgets.add(_buildProgressWidget());
    }

    return Stack(children: widgets);
  }

  FadeTransition _buildFadeTransition() {
    return FadeTransition(
      opacity: _animation,
      child: Stack(
        children: <Widget>[
          ModalBarrier(
            dismissible: false,
            color: _backgroundColor,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressWidget() {
    return Dialog(
      child: SizedBox(
        height: 80,
        width: 100,
        child: Row(
          children: [
            const SizedBox(width: 18),
            const CircularProgressIndicator(),
            const SizedBox(width: 18),
            Text(widget.progressMessage),
          ],
        ),
      ),
    );
  }

  bool _isVisible(PageProgressState state) {
    return state == PageProgressState.loading;
  }
}
