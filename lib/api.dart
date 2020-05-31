import 'package:github_search_app/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String BASE_API = "https://api.github.com";

Future<Resource<T>> makeApiCall<T>(Future<T> Function() callback) async {
  try {
    final data = await callback();
    return Resource(
      data: data,
      result: true,
    );
  } catch (error) {
    return Resource(
      result: false,
      message: error.toString(),
    );
  }
}

Future<Resource<List<GitHubRepository>>> searchRepositories(
  String query,
) async {
  return makeApiCall(() async {
    final response = await http.get('$BASE_API/search/repositories?q=$query');

    final jsonResponse = jsonDecode(response.body);
    final List<dynamic> repositories = jsonResponse['items'];
    return repositories
        .map<GitHubRepository>((item) => GitHubRepository.fromJson(item))
        .toList();
  });
}

Future<Resource<List<GitHubUser>>> searchUser(
  String query,
) async {
  return makeApiCall(() async {
    final response = await http.get("$BASE_API/search/users?q=$query");
    final jsonResponse = jsonDecode(response.body);
    final List<dynamic> repositories = jsonResponse['items'];
    return repositories
        .map<GitHubUser>((item) => GitHubUser.fromJson(item))
        .toList();
  });
}
