import 'package:organic_foods_admin/models/product_category.dart';

class Product {
  String? id;
  String? name;
  String? categoryId;
  String? size;
  String? image;
  String? shortDesc;
  double? price;
  String? longDesc;
  ProductCategory? category;

  Product({this.id, this.categoryId, this.category, this.name, this.size, this.image, this.shortDesc, this.price, this.longDesc});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    categoryId = json['categoryId'];
    category = json['category'] != null ? ProductCategory.fromJson(json['category']) : null;
    name = json['name'];
    size = json['size'];
    image = json['image'];
    shortDesc = json['shortDesc'];
    price = json['price'] != null ? double.parse(json['price'].toString()) : null;
    longDesc = json['longDesc'];
  }
}
