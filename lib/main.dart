import 'package:flutter/material.dart';
import 'package:github_search_app/api.dart' as api;
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
  final List<GitHubRepository> _repositories = [];

  void _fetchRepositories() async {
    // TODO: Check for netowrk error
    final response = await api.searchRepositories('css');
    setState(() {
      _repositories.clear();
      _repositories.addAll(response);
    });
  }

  @override
  void initState() {
    super.initState();

    //TODO: Remove this
    _fetchRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: _repositories.length,
          itemBuilder: (context, index) {
            final repository = _repositories[index];
            return Text(repository.fullName);
          },
        ),
      ),
    );
  }
}
