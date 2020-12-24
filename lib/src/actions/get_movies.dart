library get_movies;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tema_filme/src/models/movie.dart';

part 'get_movies.freezed.dart';

@freezed
abstract class GetMovies with _$GetMovies{
  const factory GetMovies.start() = GetMoviesStart;
  const factory GetMovies.successful(List<Movie> movies) = GetMoviesSuccessful;
  const factory GetMovies.error(dynamic error) = GetMoviesError;
}

/*class GetMovies {
  const GetMovies();
}

class GetMoviesSuccessful {
  const GetMoviesSuccessful(this.movies);

  final List<Movie> movies;
}

class GetMoviesError {
  const GetMoviesError(this.error);

  final dynamic error;
}*/
