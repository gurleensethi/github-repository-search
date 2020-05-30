class GitHubRepository {
  final int id;
  final String name;
  final String fullName;

  GitHubRepository({
    this.id,
    this.name,
    this.fullName,
  });

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      id: json['id'],
      name: json['name'],
      fullName: json['full_name'],
    );
  }
}
