import 'package:organic_foods_admin/models/response_status.dart';

import '../../../common/api.dart';
import '../../../constants/api_endpoints.dart';
import '../../../models/data_result.dart';
import '../../../models/product_category.dart';

class CategoryRepo {
  CategoryRepo._();

  static Future<DataResult> getCategories() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.getCategories);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => ProductCategory.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> createCategory(String body) async {
    final DataResult dataResult = DataResult();

    final result = await Api.post(ApiEndPoints.createCategory, body);

    if (result.error == null) {
      final json = result.json != null ? result.json as Map<String, dynamic> : <String, dynamic>{};

      dataResult.data = ResponseStatus.fromJson(json);
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }
}
