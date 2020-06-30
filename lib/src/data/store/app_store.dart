class AppStore {
  static final AppStore _appStore = AppStore._();
  factory AppStore() => _appStore;
  AppStore._() {}

  String _sessionCookie;

  String getSessionCookie() {
    return _sessionCookie;
  }

  void setCookie(String cookie) {
    _sessionCookie = cookie;
  }
}
