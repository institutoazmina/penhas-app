import '../../domain/entities/account_preference_entity.dart';

class AccountPreferenceModel extends AccountPreferenceEntity {
  const AccountPreferenceModel({
    required String key,
    required String? label,
    required bool value,
  }) : super(key: key, label: label, value: value);

  factory AccountPreferenceModel.fromJson(Map<String, dynamic> jsonData) {
    final string = jsonData['value'].toString();
    final parsed = (int.tryParse(string) ?? 0) == 1;

    return AccountPreferenceModel(
      key: jsonData['key'],
      label: jsonData['label'],
      value: parsed,
    );
  }
}

class AccountPreferenceSessionModel extends AccountPreferenceSessionEntity {
  const AccountPreferenceSessionModel({
    required List<AccountPreferenceModel> preferences,
  }) : super(preferences: preferences);

  factory AccountPreferenceSessionModel.fromJson(
    Map<String, dynamic> jsonData,
  ) {
    final preferences = (jsonData['preferences'] as List<dynamic>)
        .map((e) => AccountPreferenceModel.fromJson(e))
        .toList();

    return AccountPreferenceSessionModel(preferences: preferences);
  }
}
