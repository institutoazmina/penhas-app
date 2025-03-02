import 'package:flutter/material.dart';

/// A custom Tags widget that replaces the flutter_tags package
class Tags extends StatefulWidget {
  const Tags({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.spacing = 8.0,
    this.runSpacing = 4.0,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  }) : super(key: key);

  /// Number of tag items
  final int itemCount;

  /// Builder for tag items
  final Widget Function(int index) itemBuilder;

  /// Horizontal spacing between tags
  final double spacing;

  /// Vertical spacing between tag rows
  final double runSpacing;

  /// Horizontal alignment of tags
  final WrapAlignment alignment;

  /// Horizontal alignment of tag rows
  final WrapAlignment runAlignment;

  /// Vertical alignment of tags within a row
  final WrapCrossAlignment crossAxisAlignment;

  @override
  State<Tags> createState() => TagsState();
}

class TagsState extends State<Tags> {
  final List<TagItem> _items = [];

  @override
  void initState() {
    super.initState();
    _initializeItems();
  }

  void _initializeItems() {
    _items.clear();
    for (int i = 0; i < widget.itemCount; i++) {
      final item = widget.itemBuilder(i);
      if (item is TagItem) {
        _items.add(item);
      }
    }
  }

  @override
  void didUpdateWidget(Tags oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemCount != widget.itemCount) {
      _initializeItems();
    }
  }

  /// Get all tag items
  List<TagItem> get getAllItem => _items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      alignment: widget.alignment,
      runAlignment: widget.runAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: List.generate(
        widget.itemCount,
        (index) => widget.itemBuilder(index),
      ),
    );
  }
}

/// A custom tag item that replaces ItemTags from flutter_tags
class TagItem extends StatefulWidget {
  const TagItem({
    Key? key,
    required this.index,
    required this.title,
    this.active = false,
    this.customData,
    this.activeColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.textActiveColor = Colors.white,
    this.elevation = 0.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(20.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    this.textStyle,
    this.onPressed,
    this.pressEnabled = true,
  }) : super(key: key);

  /// Index of the tag
  final int index;

  /// Title text of the tag
  final String title;

  /// Whether the tag is active/selected
  final bool active;

  /// Custom data associated with the tag
  final dynamic customData;

  /// Color when the tag is active
  final Color activeColor;

  /// background color [ItemTags]
  final Color backgroundColor;

  /// Text color when the tag is inactive
  final Color textColor;

  /// Text color when the tag is active
  final Color textActiveColor;

  /// Elevation of the tag
  final double elevation;

  /// Border radius of the tag
  final BorderRadius borderRadius;

  /// Padding inside the tag
  final EdgeInsetsGeometry padding;

  /// Text style for the tag title
  final TextStyle? textStyle;

  /// Callback when the tag is pressed
  final VoidCallback? onPressed;

  /// Whether the tag is pressable
  final bool pressEnabled;

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  late bool _active;

  @override
  void initState() {
    super.initState();
    _active = widget.active;
  }

  @override
  void didUpdateWidget(TagItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active != widget.active) {
      _active = widget.active;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      borderRadius: widget.borderRadius,
      color: _active ? widget.activeColor : widget.backgroundColor,
      child: widget.pressEnabled
          ? InkWell(
              borderRadius: widget.borderRadius,
              onTap: () {
                setState(() {
                  _active = !_active;
                });
                if (widget.onPressed != null) {
                  widget.onPressed!();
                }
              },
              child: _buildTagContent(),
            )
          : _buildTagContent(),
    );
  }

  Widget _buildTagContent() {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: Border.all(
          color: _active
              ? widget.activeColor
              : widget.activeColor.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      child: Text(
        widget.title,
        style: widget.textStyle?.copyWith(
              color: _active ? widget.textActiveColor : widget.textColor,
            ) ??
            TextStyle(
              color: _active ? widget.textActiveColor : widget.textColor,
            ),
      ),
    );
  }
}
