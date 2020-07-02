import 'package:flutter_research_development/src/constants/api_services_urls.dart';
import 'package:flutter_research_development/src/data/network/http_client.dart';
import 'package:flutter_research_development/src/models/home/product_list_response_model.dart';

class HomeRepository {
  Future<ProductListResponseModel> fetchProductList() async {
    final Map<String, dynamic> resp =
        await HTTPClient().getJSONRequest(url: ApiServiceUrls.fetchProductList);
    return ProductListResponseModel.fromJson(resp);
  }
}
