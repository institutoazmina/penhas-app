  /// Creates a new instance of [SecurityToggleState] with a title, current enabled state and a callback function.
  /// 
  /// [title] is the title of the toggle.
  /// [isEnabled] is the current state of the toggle.
  /// [onChanged] is the callback function that is called when the toggle state changes.
  SecurityToggleState({
    required this.title,
    required this.isEnabled,
    required this.onChanged,
  });

  /// Creates an empty instance of [SecurityToggleState].
  ///
  /// The created instance has an empty title, is in the disabled state and has an empty callback function.
  factory SecurityToggleState.empty() => SecurityToggleState(
        title: '',
        isEnabled: false,
        onChanged: (_) {},
      );

  /// The title of the toggle.
  final String title;

  /// The current state of the toggle.
  final bool? isEnabled;

  /// The callback function that is called when the toggle state changes.
  final void Function(bool value) onChanged;
}
