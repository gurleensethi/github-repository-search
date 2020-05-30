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
  final _controller = TextEditingController();
  bool _isLoading = false;

  void _fetchRepositories() async {
    // TODO: Check for netowrk error
    setState(() {
      _isLoading = true;
    });
    final text = _controller.text;
    if (text == null && text.trim().isEmpty) {
      return;
    }
    final response = await api.searchRepositories(text);
    setState(() {
      _isLoading = false;
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
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: !_isLoading,
                    controller: _controller,
                  ),
                ),
                RaisedButton(
                  child: Text('Search'),
                  onPressed: _isLoading ? null : _fetchRepositories,
                ),
              ],
            ),
            if (_isLoading)
              Container(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            if (!_isLoading)
              Expanded(
                child: ListView.builder(
                  itemCount: _repositories.length,
                  itemBuilder: (context, index) {
                    final repository = _repositories[index];
                    return Text(repository.fullName);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
