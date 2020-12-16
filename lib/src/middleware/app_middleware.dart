import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:tema_filme/src/actions/get_movies.dart';
import 'package:tema_filme/src/data/yts_api.dart';
import 'package:tema_filme/src/models/app_state.dart';
import 'package:tema_filme/src/models/movie.dart';

class AppMiddleware {
  const AppMiddleware({@required YtsApi ytsApi})
      : assert(ytsApi != null),
        _ytsApi = ytsApi;

  final YtsApi _ytsApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      _getMoviesMiddleware,
    ];
  }

  Future<void> _getMoviesMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is! GetMovies) {
      return;
    }

    try {
      print('succes');
      final List<Movie> movies = await _ytsApi.getMovies();
      print('succes');
      final GetMoviesSuccessful successful = GetMoviesSuccessful(movies);
      print('succes');
      store.dispatch(successful);
    } catch (e) {
      final GetMoviesError error = GetMoviesError(e);
      print(error.error.toString());
      store.dispatch(error);
    }
  }
}
