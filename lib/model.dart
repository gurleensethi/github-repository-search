class GitHubRepository {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final int stars;
  final String language;
  final int forks;

  GitHubRepository({
    this.id,
    this.name,
    this.fullName,
    this.description,
    this.stars,
    this.language,
    this.forks,
  });

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      id: json['id'],
      name: json['name'],
      fullName: json['full_name'],
      description: json['description'] ?? "No description found...",
      stars: json['stargazers_count'],
      language: json['language'] ?? "N/A",
      forks: json['forks'],
    );
  }
}

class Resource<T> {
  final bool result;
  final T data;
  final String message;

  Resource({
    this.result,
    this.data,
    this.message = "",
  });
}

class GitHubUser {
  final String login;
  final int id;
  final String avatarUrl;
  final String url;

  GitHubUser({
    this.id,
    this.login,
    this.url,
    this.avatarUrl,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      id: json['id'],
      avatarUrl: json['avatar_url'],
      login: json['login'],
      url: json['url'],
    );
  }
}
