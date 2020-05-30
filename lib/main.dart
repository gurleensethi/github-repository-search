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
  final _controller = TextEditingController();
  bool _isLoading = false;
  Resource<List<GitHubRepository>> _data;

  bool get _isSuccess => _data != null && _data.result;
  bool get _isError => _data != null && !_data.result;

  void _fetchRepositories() async {
    setState(() {
      _isLoading = true;
    });
    final text = _controller.text;
    if (text == null && text.trim().isEmpty) {
      return;
    }
    final resource = await api.searchRepositories(text);
    setState(() {
      _isLoading = false;
      _data = resource;
    });
  }

  @override
  void initState() {
    super.initState();
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
            if (_isLoading && _isSuccess)
              Container(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            if (_isError) Text(_data.message),
            if (!_isLoading && _isSuccess)
              Expanded(
                child: ListView.builder(
                  itemCount: _data.data.length,
                  itemBuilder: (context, index) {
                    final repository = _data.data[index];
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
