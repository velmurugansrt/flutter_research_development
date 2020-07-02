class ProductListResponseModel {
  List<ProductList> productList;

  ProductListResponseModel({this.productList});

  ProductListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['productList'] != null) {
      productList = new List<ProductList>();
      json['productList'].forEach((v) {
        productList.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productList != null) {
      data['productList'] = this.productList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String name;
  String decription;
  String price;
  String image;

  ProductList({this.name, this.decription, this.price, this.image});

  ProductList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    decription = json['decription'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['decription'] = this.decription;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}