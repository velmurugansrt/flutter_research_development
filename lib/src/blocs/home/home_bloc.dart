import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_research_development/src/data/repository/home/home_repository.dart';
import 'package:flutter_research_development/src/models/home/product_list_response_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchUserLoginEvent) {
      yield* _handleFetchUserLoginEvent(event);
    }
  }

  Stream<HomeState> _handleFetchUserLoginEvent(
      FetchUserLoginEvent event) async* {
    final ProductListResponseModel userListModel =
        await HomeRepository().fetchProductList();
    yield ProductListState(userListModel.productList);
  }
}
