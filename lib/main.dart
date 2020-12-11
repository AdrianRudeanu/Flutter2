import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tema_filme/movie.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Movies'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> movieList = <Movie>[];
  double minRating = 0;
  String genre = 'All';

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  Future<List<Movie>> fetchMovies() async {
    final List<Movie> thisMovieList = <Movie>[];

    String baseUrl = 'https://yts.mx/api/v2/list_movies.json';

    String wantedUrl = baseUrl;

    if (minRating != 0 || genre != 'All') {
      wantedUrl += '?';
    }

    if (minRating != 0) {
      wantedUrl = wantedUrl + 'minimum_rating=' + minRating.toString();
    }

    if (genre != 'All') {
      if (minRating != 0) {
        wantedUrl += '&';
      }
      wantedUrl = wantedUrl + 'genre=' + genre;
    }

    Response response = await get(wantedUrl);

    Map<String, dynamic> parsedResponse = json.decode(response.body);

    final int nrOfMovies = parsedResponse['data']['limit'];

    for (int i = 0; i < nrOfMovies; i++) {
      thisMovieList.add(Movie.fromJson(parsedResponse['data']['movies'][i]));
    }

    return thisMovieList;
  }

  Future<List<Movie>> getMovies() async {
    List<Movie> this_list = await fetchMovies();

    setState(() {
      movieList = this_list;
    });

    return movieList;
  }

  Future<Response> fetchMovies2() async {
    Response response = await get('https://yts.mx/api/v2/list_movies.json');

    return response;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.amber,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Minimum rating: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                          value: minRating.toInt().toString(),
                          style: const TextStyle(color: Colors.deepOrange),
                          onChanged: (String newValue) {
                            setState(() {
                              minRating = int.parse(newValue).toDouble();
                            });
                          },
                          items: <String>['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Genre: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                          value: genre,
                          style: const TextStyle(color: Colors.deepOrange),
                          onChanged: (String newValue) {
                            setState(() {
                              genre = newValue;
                            });
                          },
                          items: <String>[
                            'All',
                            'Drama',
                            'Comedy',
                            'Action',
                            'Crime',
                            'Sci-Fi',
                            'Adventure',
                            'War',
                            'Family'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: getMovies(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: movieList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Row(
                                  children: <Widget>[
                                    Image.network(movieList[index].imageUrl),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(movieList[index].title),
                                            subtitle: Text('' +
                                                movieList[index].rating.toString() +
                                                '/10 \nYear: ' +
                                                movieList[index].year.toString()),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.info_outline),
                                      onPressed: () {
                                        _launchURL(movieList[index].url);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }));
                  }
                })
          ],
        ),
      ),
    );
  }
}
