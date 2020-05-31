import 'package:flutter/material.dart';

class GithubResourceList<T> extends StatelessWidget {
  final String headerText;
  final List<T> data;
  final Widget Function(BuildContext context, T data) builder;

  const GithubResourceList({
    Key key,
    @required this.headerText,
    @required this.data,
    @required this.builder,
  })  : assert(headerText != null),
        assert(data != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.0),
      child: Card(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  this.headerText,
                  style: TextStyle(
                    fontSize: 18.0,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return builder(context, item);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
