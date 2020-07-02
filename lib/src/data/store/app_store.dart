import 'package:flutter_research_development/src/models/login/user_list_response_model.dart';

class AppStore {
  static final AppStore _appStore = AppStore._();
  factory AppStore() => _appStore;
  AppStore._() {}

  String _sessionCookie;
  UserList _userDetails;

  String getSessionCookie() {
    return _sessionCookie;
  }

  void setCookie(String cookie) {
    _sessionCookie = cookie;
  }

  void setUserDetails(UserList userData) {
    _userDetails = userData;
  }

  UserList getUserDetails() {
    return _userDetails;
  }
}
