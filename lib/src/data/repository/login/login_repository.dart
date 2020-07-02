import 'package:flutter_research_development/src/constants/api_services_urls.dart';
import 'package:flutter_research_development/src/data/network/http_client.dart';
import 'package:flutter_research_development/src/models/login/user_list_response_model.dart';

class LoginRepository {
  Future<UserListResponseModel> fetchuserList() async {
    final Map<String, dynamic> resp =
        await HTTPClient().getJSONRequest(url: ApiServiceUrls.fetchUserList);
    return UserListResponseModel.fromJson(resp);
  }
}
