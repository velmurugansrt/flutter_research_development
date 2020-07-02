import 'package:flutter_research_development/src/config/app_config.dart';

class ApiServiceUrls {
  static String baseURL = AppConfig.baseURL;
  static String fetchUserList = baseURL + 'users';
  static String fetchProductList = baseURL + 'products';
}
