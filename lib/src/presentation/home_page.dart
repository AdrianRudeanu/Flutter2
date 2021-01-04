// File created by
// Lung Razvan <long1eu>
// on 14/12/2020

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tema_filme/src/containers/index.dart';
import 'package:tema_filme/src/models/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MoviesContainer(
      builder: (BuildContext context, List<Movie> movies) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Movies'),
          ),
          body: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Image.network(movies[index].mediumCover),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(movies[index].title),
                              subtitle: Text('' +
                                  movies[index].rating.toString() +
                                  '/10 \nYear: ' +
                                  movies[index].year.toString()),
                            ),
                          ],
                        ),
                      ),
                      const IconButton(
                        icon: Icon(Icons.info_outline),
                      ),
                    ],
                  ),
                );
              })
        );
      },
    );
  }
}
