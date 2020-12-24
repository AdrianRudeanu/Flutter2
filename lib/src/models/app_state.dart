library app_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'movie.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState(){
        return _$AppState((AppStateBuilder b){
          b.isLoading = false;
    });
  }

  AppState._();

  BuiltList<Movie> get movies;

  bool get isLoading;
}
