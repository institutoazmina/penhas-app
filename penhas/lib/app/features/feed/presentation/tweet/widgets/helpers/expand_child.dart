import 'package:flutter/material.dart';

/// Default animation duration
const Duration _kExpand = Duration(milliseconds: 300);

/// This widget unfolds a hidden widget to the user, called [child].
/// This action is performed when the user clicks the 'expand' arrow.
class ExpandChild extends StatefulWidget {
  const ExpandChild({
    Key? key,
    this.collapsedHint,
    this.expandedHint,
    this.arrowPadding,
    this.arrowColor,
    this.arrowSize = 30,
    this.icon,
    this.hintTextStyle,
    this.expandArrowStyle = ExpandArrowStyle.icon,
    this.animationDuration = _kExpand,
    required this.child,
    this.hideArrowOnExpanded = false,
    this.alignment = Alignment.topCenter,
    this.trimSize = 0,
  }) : super(key: key);

  /// Message used as a tooltip when the widget is minimized.
  /// Default value set to [MaterialLocalizations.of(context).collapsedIconTapHint].
  final String? collapsedHint;

  /// Message used as a tooltip when the widget is maximazed.
  /// Default value set to [MaterialLocalizations.of(context).expandedIconTapHint].
  final String? expandedHint;

  /// Defines padding value.
  ///
  /// Default value if this widget's icon-only: [EdgeInsets.all(4)].
  /// If text is shown: [EdgeInsets.all(8)].
  final EdgeInsets? arrowPadding;

  /// Color of the arrow widget. Defaults to the caption text style color.
  final Color? arrowColor;

  /// Size of the arrow widget. Default is [30].
  final double arrowSize;

  /// Icon that will be used instead of an arrow.
  /// Default is [Icons.expand_more].
  final IconData? icon;

  /// Style of the displayed message.
  final TextStyle? hintTextStyle;

  /// Defines arrow rendering style.
  final ExpandArrowStyle expandArrowStyle;

  /// How long the expanding animation takes. Default is 300ms.
  final Duration animationDuration;

  /// This widget will be displayed if the user clicks the 'expand' arrow.
  final Widget child;

  /// Ability to hide arrow from display when content is expanded.
  final bool hideArrowOnExpanded;

  final double? trimSize;

  final Alignment alignment;

  const ExpandChild({
    required Key key,
    this.collapsedHint,
    this.expandedHint,
    this.arrowPadding,
    this.arrowColor,
    this.arrowSize = 30,
    this.icon,
    this.hintTextStyle,
    this.expandArrowStyle = ExpandArrowStyle.icon,
    this.animationDuration = _kExpand,
    required this.child,
    this.hideArrowOnExpanded = false,
    this.alignment = Alignment.topCenter,
    this.trimSize,
  })  : assert(hideArrowOnExpanded != null),
        super(key: key);

  @override
  _ExpandChildState createState() => _ExpandChildState();
}

class _ExpandChildState extends State<ExpandChild>
    with SingleTickerProviderStateMixin {
  /// Custom animation curve for arrow controll.
  static final _easeInCurve = CurveTween(curve: Curves.easeInOutCubic);

  /// Controlls the rotation of the arrow widget.
  static final _halfTurn = Tween<double>(begin: 0.0, end: 0.5);

  /// General animation controller.
  late AnimationController _controller;

  /// Animations for height control.
  late Animation<double> _heightFactor;

  /// Animations for arrow's rotation control.
  late Animation<double> _iconTurns;

  /// Auxiliary variable to controll expand status.
  bool _isExpanded = false;

  final GlobalKey _localChildrenKey = GlobalKey();
  double _foo = 0.0;
  bool _showExpand = true;

  @override
  void initState() {
    super.initState();

    // Initializing the animation controller with the [duration] parameter
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Initializing both animations, depending on the [_easeInCurve] curve
    _heightFactor = _controller.drive(_easeInCurve);
    _iconTurns = _controller.drive(_halfTurn.chain(_easeInCurve));

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final context = _localChildrenKey.currentContext;
      if (context == null) return;

      setState(() {
        _foo = widget.trimSize! > context.size.height
            ? 1.0
            : widget.trimSize! / context.size.height;

        _showExpand = context.size.height > widget.trimSize!;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Method called when the user clicks on the expand arrow
  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  /// Builds the widget itself. If the [_isExpanded] parameter is 'true',
  /// the [child] parameter will contain the child information, passed to
  /// this instance of the object.
  Widget _buildChild(BuildContext context, Widget? child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRect(
          child: Align(
            alignment: widget.alignment,
            heightFactor:
                _heightFactor.value > _foo ? _heightFactor.value : _foo,
            child: Container(key: _localChildrenKey, child: child),
          ),
        ),
        if (_showExpand)
          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor:
                  widget.hideArrowOnExpanded ? 1 - _heightFactor.value : 1,
              child: InkWell(
                onTap: _handleTap,
                child: ExpandArrow(
                  collapsedHint: widget.collapsedHint,
                  expandedHint: widget.expandedHint,
                  animation: _iconTurns,
                  padding: widget.arrowPadding,
                  onTap: _handleTap,
                  arrowColor: widget.arrowColor,
                  arrowSize: widget.arrowSize,
                  icon: widget.icon,
                  hintTextStyle: widget.hintTextStyle,
                  expandArrowStyle: widget.expandArrowStyle,
                ),
              ),
            ),
          )
        else
          Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChild,
      child: widget.child,
    );
  }
}

/// Render mode selection of the [ExpandArrow] widget.
enum ExpandArrowStyle {
  /// Only display an icon, tipically a [Icons.expand_more] icon.
  icon,

  /// Display just the text. It will be dependant on the widget state.
  text,

  /// Display both icon & text at the same tame, using a [Row] widget.
  both,
}

/// This widget is used in both [ExpandChild] & [ExpandText] widgets to show
/// the hidden information to the user. It posses an [animation] parameter.
/// Most widget parameters are customizable.
class ExpandArrow extends StatelessWidget {
  const ExpandArrow({
    Key? key,
    this.collapsedHint,
    this.expandedHint,
    required this.animation,
    this.padding,
    this.onTap,
    this.arrowColor,
    this.arrowSize,
    this.icon,
    this.hintTextStyle,
    this.expandArrowStyle,
  }) : super(key: key);

  /// String used as a tooltip when the widget is minimized.
  /// Default value set to [MaterialLocalizations.of(context).collapsedIconTapHint].
  final String? collapsedHint;

  /// String used as a tooltip when the widget is maximazed.
  /// Default value set to [MaterialLocalizations.of(context).expandedIconTapHint].
  final String? expandedHint;

  /// Controlls the arrow's fluid(TM) animation for
  /// the arrow's rotation.
  final Animation<double> animation;

  /// Defines padding value.
  ///
  /// Default value if this widget's icon-only: [EdgeInsets.all(4)].
  /// If text is shown: [EdgeInsets.all(8)].
  final EdgeInsets? padding;

  /// Callback to controll what happeds when the arrow is clicked.
  final void Function()? onTap;

  /// Defines arrow's color.
  final Color? arrowColor;

  /// Defines arrow's size. Default is [30].
  final double? arrowSize;

  /// Icon that will be used instead of an arrow.
  /// Default is [Icons.expand_more].
  final IconData? icon;

  /// Style of the displayed message.
  final TextStyle? hintTextStyle;

  ///  Defines arrow rendering style. Default is [ExpandArrowStyle.icon].
  final ExpandArrowStyle? expandArrowStyle;

  const ExpandArrow({
    required Key key,
    this.collapsedHint,
    this.expandedHint,
    required this.animation,
    this.padding,
    this.onTap,
    this.arrowColor,
    this.arrowSize,
    this.icon,
    this.hintTextStyle,
    this.expandArrowStyle,
  })  : assert(animation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final tooltipMessage = animation.value < 0.25
        ? collapsedHint ??
            MaterialLocalizations.of(context).collapsedIconTapHint
        : expandedHint ?? MaterialLocalizations.of(context).expandedIconTapHint;

    final isNotIcon = expandArrowStyle == ExpandArrowStyle.text ||
        expandArrowStyle == ExpandArrowStyle.both;

    return Tooltip(
      message: tooltipMessage,
      child: InkResponse(
        containedInkWell: isNotIcon,
        highlightShape: isNotIcon ? BoxShape.rectangle : BoxShape.circle,
        onTap: onTap,
        child: Padding(
          padding: padding ??
              EdgeInsets.all(expandArrowStyle == ExpandArrowStyle.text ? 8 : 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (expandArrowStyle != ExpandArrowStyle.text)
                RotationTransition(
                  turns: animation,
                  child: Icon(
                    icon ?? Icons.expand_more,
                    color:
                        arrowColor ?? Theme.of(context).textTheme.caption.color!,
                    size: arrowSize ?? 30,
                  ),
                ),
              if (isNotIcon) ...[
                const SizedBox(width: 2.0),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: Theme.of(context).textTheme.caption?.color,
                          ) ??
                      const TextStyle(),
                  child: Text(
                    tooltipMessage,
                    style: hintTextStyle!,
                  ),
                ),
                const SizedBox(width: 2.0),
              ]
            ],
          ),
        ),
        onTap: onTap!,
      ),
    );
  }
}
