import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_research_development/src/data/repository/login/login_repository.dart';
import 'package:flutter_research_development/src/data/store/app_store.dart';
import 'package:flutter_research_development/src/models/login/user_list_response_model.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is FetchUserLoginEvent) {
      yield* _handleFetchUserLoginEvent(event);
    }
  }

  Stream<LoginState> _handleFetchUserLoginEvent(
      FetchUserLoginEvent event) async* {
    final UserListResponseModel userListModel =
        await LoginRepository().fetchuserList();
    final int userIndex = userListModel.userList.indexWhere(
        (UserList element) =>
            element.username == event.username &&
            element.password == event.password);
    if (userIndex != -1) {
      AppStore().setUserDetails(userListModel.userList[userIndex]);
      yield LoginSuccessState();
    } else {
      yield LoginFailedState();
    }
  }
}
