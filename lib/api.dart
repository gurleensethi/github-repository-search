import 'package:github_search_app/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Resource<List<GitHubRepository>>> searchRepositories(
    String query) async {
  try {
    final response =
        await http.get('https://api.github.com/search/repositories?q=$query');

    final jsonResponse = jsonDecode(response.body);
    final List<dynamic> repositories = jsonResponse['items'];
    final data = repositories
        .map<GitHubRepository>((item) => GitHubRepository.fromJson(item))
        .toList();

    return Resource(
      data: data,
      result: true,
    );
  } catch (error) {
    return Resource(
      result: false,
      message: error.message,
    );
  }
}
