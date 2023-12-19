import '../../../common/api.dart';
import '../../../constants/api_endpoints.dart';
import '../../../models/data_result.dart';
import '../../../models/order.dart';
import '../../../models/response_status.dart';

class OrderRepo {
  OrderRepo._();

  static Future<DataResult> allOrders() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.allOrders());

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => Order.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> updateOrderStatus(String body) async {
    final DataResult dataResult = DataResult();

    final result = await Api.post(ApiEndPoints.updateOrderStatus, body);

    if (result.error == null) {
      final json = result.json != null ? result.json as Map<String, dynamic> : <String, dynamic>{};

      dataResult.data = ResponseStatus.fromJson(json);
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }
}
