

import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tema_filme/src/models/app_state.dart';


class IsLoadingContainer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,bool>(
      converter:(Store<AppState> store)=> store.state.isLoading,
      builder:null
    );
  }
}