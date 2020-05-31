import 'package:flutter/material.dart';

class GithubResourceList<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(BuildContext context, T data) builder;

  const GithubResourceList({
    Key key,
    @required this.data,
    @required this.builder,
  })  : assert(data != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 80),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return builder(context, item);
      },
    );
  }
}
