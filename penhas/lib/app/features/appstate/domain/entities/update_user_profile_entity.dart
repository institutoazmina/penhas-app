class UpdateUserProfileEntity {
  final String? nickName;
  final String? email;
  final String? newPassword;
  final String? oldPassword;
  final String? minibio;
  final String? race;
  final List<String>? skills;

  UpdateUserProfileEntity({
    this.nickName,
    this.email,
    this.newPassword,
    this.oldPassword,
    this.minibio,
    this.race,
    this.skills,
  }) {
    if ((email != null || newPassword != null) &&
        (oldPassword == null || oldPassword!.isEmpty)) {
      throw 'Precisa da senha atual para alterar a senha ou email';
    }
  }

  final String? nickName;
  final String? email;
  final String? newPassword;
  final String? oldPassword;
  final String? minibio;
  final String? race;
  final List<String>? skills;
}
