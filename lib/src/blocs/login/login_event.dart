part of 'login_bloc.dart';

abstract class LoginEvent {}

class FetchUserLoginEvent extends LoginEvent {
  String username;
  String password;
  FetchUserLoginEvent(this.username,this.password);
}
