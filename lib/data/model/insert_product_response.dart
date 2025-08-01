class InsertProductResponse {
  bool? success;
  String? message;
  DataNewProduct? data;

  InsertProductResponse({this.success, this.message, this.data});

  InsertProductResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DataNewProduct.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataNewProduct {
  String? image;
  String? title;
  String? description;
  String? price;
  String? stock;
  String? updatedAt;
  String? createdAt;
  int? id;

  DataNewProduct(
      {this.image,
      this.title,
      this.description,
      this.price,
      this.stock,
      this.updatedAt,
      this.createdAt,
      this.id});

  DataNewProduct.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}