import 'package:flutter/material.dart';
import 'package:github_search_app/model.dart';

class GithubRepositoryCard extends StatelessWidget {
  final GitHubRepository repository;

  const GithubRepositoryCard({
    Key key,
    this.repository,
  })  : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            repository.fullName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            repository.description,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 8.0,
                      width: 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 4.0),
                    Text(repository.language),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 16.0,
                    ),
                    SizedBox(width: 4.0),
                    Text('${repository.stars}'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.play_for_work,
                      color: Colors.orange,
                      size: 16.0,
                    ),
                    SizedBox(width: 4.0),
                    Text('${repository.forks}'),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
