import 'package:meta/meta.dart';

class SecurityToggleState {
  final String title;
  final bool isEnabled;
  final void Function(bool value) onChanged;

  SecurityToggleState({
    @required this.title,
    @required this.isEnabled,
    @required this.onChanged,
  });

  static SecurityToggleState empty() {
    return SecurityToggleState(
      title: '',
      isEnabled: false,
      onChanged: (_) {},
    );
  }
}
