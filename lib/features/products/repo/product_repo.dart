import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../common/api.dart';
import '../../../constants/api_endpoints.dart';
import '../../../constants/app_helper.dart';
import '../../../constants/app_strings.dart';
import '../../../models/data_result.dart';
import '../../../models/product.dart';
import '../../../models/response_status.dart';

class ProductRepo {
  ProductRepo._();

  static Future<DataResult> getProducts() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.getProducts());

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => Product.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> createProduct(Product product, List<String> images) async {
    DataResult dataResult = DataResult();

    try {
      final token = await AppHelper.getToken();
      var headers = {'Authorization': 'Bearer $token'};

      var url = Uri.parse(ApiEndPoints.createProduct);

      var request = http.MultipartRequest("POST", url);

      request.headers.addAll(headers);

      for (var img in images) {
        String ext = img.split('.').last;

        var file = await http.MultipartFile.fromPath("images", img, contentType: MediaType('image', ext));
        request.files.add(file);
      }

      request.fields["name"] = product.name ?? "";
      request.fields["size"] = product.size ?? "";
      request.fields["price"] = product.price.toString();
      request.fields["categoryId"] = product.categoryId ?? "";
      request.fields["shortDesc"] = product.shortDesc ?? "";
      request.fields["longDesc"] = product.longDesc ?? "";

      final response = await request.send();

      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      final json = jsonDecode(responseString);

      if (response.statusCode == 200 || response.statusCode == 201) {
        dataResult.data = ResponseStatus.fromJson(json);
      } else {
        dataResult.error = AppHelper.handleError(response.statusCode, json);
      }
    } catch (e) {
      dataResult.error = AppString.somethingWentWrong;
    }

    return dataResult;
  }
}
