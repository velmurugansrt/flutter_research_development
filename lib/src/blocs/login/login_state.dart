part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginResponseState extends LoginState {
  UserListResponseModel userList;
  LoginResponseState(this.userList);
}
