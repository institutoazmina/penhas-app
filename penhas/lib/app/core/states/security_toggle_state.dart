class SecurityToggleState {
  SecurityToggleState({
    required this.title,
    required this.isEnabled,
    required this.onChanged,
  });

  factory SecurityToggleState.empty() => SecurityToggleState(
        title: '',
        isEnabled: false,
        onChanged: (_) {},
      );

  final String title;
  final bool? isEnabled;
  final void Function(bool value) onChanged;
}
