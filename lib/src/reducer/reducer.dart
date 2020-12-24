import 'package:tema_filme/src/actions/get_movies.dart';
import 'package:tema_filme/src/models/app_state.dart';

AppState reducer(AppState state, dynamic action) {

  if(action is GetMoviesStart){
    final AppStateBuilder builder = state.toBuilder();
    builder.isLoading = true;
    return builder.build();
  }else if (action is GetMoviesSuccessful) {
    final AppStateBuilder builder = state.toBuilder();
    builder.movies.addAll(action.movies);
    builder.isLoading = false;
    //print(action.movies);
    return builder.build();
  }else if(action is GetMoviesError){

  }

  return state;
}
