import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:tema_filme/src/models/movie.dart';

class YtsApi {
  const YtsApi({@required Client client})
      : assert(client != null),
        _client = client;

  final Client _client;

  Future<List<Movie>> getMovies() async {
    final Response response = await _client.get('https://yts.mx/api/v2/list_movies.json?limit=50');

    final List<dynamic> data = jsonDecode(response.body)['data']['movies'];
    print('got data');
    List<Movie> object = data.map((dynamic json) => Movie.fromJson(json)).toList();
    print('this is data');
    print(object[0].toString());
    return object;
  }
}
