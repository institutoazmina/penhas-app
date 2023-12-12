import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  const ContactEntity({
    required this.id,
    required this.name,
    required this.phone,
  });

  final int id;
  final String name;
  final String phone;

  @override
  List<Object?> get props => [id, name, phone];

  ContactEntity copyWith({
    required String name,
    required String phone,
  }) =>
      ContactEntity(
        id: id,
        name: name,
        phone: phone,
      );
}
