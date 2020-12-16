import 'package:tema_filme/src/actions/get_movies.dart';
import 'package:tema_filme/src/models/app_state.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is GetMoviesSuccessful) {
    final AppStateBuilder builder = state.toBuilder();
    builder.movies.addAll(action.movies);
    print(action.movies);
    return builder.build();
  }

  return state;
}
