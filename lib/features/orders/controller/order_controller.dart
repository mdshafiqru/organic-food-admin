import 'package:get/get.dart';
import 'package:organic_foods_admin/features/orders/repo/order_repo.dart';

import '../../../models/data_result.dart';
import '../../../models/order.dart';

class OrderController extends GetxController {
  var allOrders = <Order>[].obs;

  var loading = false.obs;

  getAllOrders() async {
    loading.value = true;
    final DataResult dataResult = await OrderRepo.allOrders();

    if (dataResult.error == null) {
      final itemList = dataResult.data != null ? dataResult.data as List<Order> : <Order>[];

      allOrders.clear();
      for (var item in itemList) {
        allOrders.add(item);
      }
    }
    loading.value = false;
  }

  @override
  void onInit() {
    getAllOrders();
    super.onInit();
  }
}
