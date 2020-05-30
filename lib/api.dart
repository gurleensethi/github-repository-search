import 'package:github_search_app/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<GitHubRepository>> searchRepositories(String query) async {
  final response =
      await http.get('https://api.github.com/search/repositories?q=$query');

  final jsonResponse = jsonDecode(response.body);
  final List<dynamic> repositories = jsonResponse['items'];
  return repositories
      .map<GitHubRepository>((item) => GitHubRepository.fromJson(item))
      .toList();
}
