import 'package:flutter/material.dart';
import 'package:github_search_app/github_resource_list.dart';
import 'package:github_search_app/api.dart' as api;
import 'package:github_search_app/github_repository_card.dart';
import 'package:github_search_app/model.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();
  bool _isLoading = false;
  Resource<List<GitHubRepository>> _repositories;
  Resource<List<GitHubUser>> _users;

  bool get _isSuccess =>
      _repositories != null &&
      _repositories.result &&
      _users != null &&
      _users.result;

  bool get _isError =>
      (_repositories != null && !_repositories.result) ||
      (_users != null && !_users.result);

  void _fetchRepositories() async {
    setState(() {
      _isLoading = true;
    });
    final text = _controller.text;
    if (text == null && text.trim().isEmpty) {
      return;
    }
    final response = await Future.wait([
      api.searchRepositories(text),
      api.searchUser(text),
    ]);

    setState(() {
      _isLoading = false;
      _repositories = response[0];
      _users = response[1];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                _topBar,
                if (_isLoading && _isSuccess)
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (_isError)
                  Center(
                    child: Text(_repositories.message),
                  ),
                if (!_isLoading && _isSuccess)
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      primary: true,
                      children: [
                        GithubResourceList<GitHubRepository>(
                          headerText: 'Repositories',
                          data: _repositories.data,
                          builder: (context, item) {
                            return GithubRepositoryCard(repository: item);
                          },
                        ),
                        GithubResourceList<GitHubUser>(
                          headerText: 'Users',
                          data: _users.data,
                          builder: (context, item) {
                            return Container(
                              child: Text(item.login),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _topBar {
    return SafeArea(
      child: Card(
        color: Color(0xFF333333),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  enabled: !_isLoading,
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: _isLoading ? null : _fetchRepositories,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
