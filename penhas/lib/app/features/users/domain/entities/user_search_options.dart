class UserSearchOptions {
  UserSearchOptions({
    this.name,
    this.skills,
    this.nextPage,
    this.rows,
  });

  final String? name;
  final List<String>? skills;
  final String? nextPage;
  final int? rows;
}
