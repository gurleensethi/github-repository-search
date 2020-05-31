import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                if (_isLoading && _isSuccess)
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                if (_isError)
                  Positioned.fill(
                    child: Center(
                      child: Text(_data.message),
                    ),
                  ),
                if (!_isLoading && _isSuccess)
                  ListView.builder(
                    padding: EdgeInsets.only(top: 80),
                    itemCount: _data.data.length,
                    itemBuilder: (context, index) {
                      final repository = _data.data[index];
                      return GithubRepositoryCard(repository: repository);
                    },
                  ),
                SafeArea(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
