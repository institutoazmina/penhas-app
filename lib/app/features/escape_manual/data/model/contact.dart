import '../../domain/entity/contact.dart';

export '../../domain/entity/contact.dart';

class ContactModel extends ContactEntity {
  const ContactModel({
    required int id,
    required String name,
    required String phone,
  }) : super(
          id: id,
          name: name,
          phone: phone,
        );

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json['id'] as int,
        name: json['name'] as String,
        phone: json['phone'] as String,
      );

  static List<ContactEntity> fromJsonList(List<dynamic> json) =>
      json.map<ContactEntity>((e) => ContactModel.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
      };
}
