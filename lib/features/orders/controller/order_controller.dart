import 'dart:convert';

import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/status.dart';
import 'package:organic_foods_admin/features/orders/repo/order_repo.dart';

import '../../../constants/app_helper.dart';
import '../../../models/data_result.dart';
import '../../../models/order.dart';
import '../../../models/response_status.dart';

class OrderController extends GetxController {
  var allOrders = <Order>[].obs;

  var loading = false.obs;

  var updating = false.obs;

  var selectedStatus = "".obs;
  var reason = "";

  var statusList = <String>[Status.accepted, Status.shipped, Status.delivered, Status.rejected, Status.cancelled, Status.pending];

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

  updateOrderStatus(String orderId) async {
    if (selectedStatus.isEmpty) {
      return AppHelper.showToast(message: "Select Order Status First");
    }

    if (!updating.value) {
      updating.value = true;

      final body = jsonEncode({
        "id": orderId,
        "status": selectedStatus.value,
        "reason": reason,
      });

      final result = await OrderRepo.updateOrderStatus(body);

      if (result.error == null) {
        final status = result.data != null ? result.data as ResponseStatus : ResponseStatus();

        bool success = status.success ?? false;

        if (success) {
          getAllOrders();
          updating.value = false;
          AppHelper.showToast(message: status.message ?? "");
          Get.back();
          Get.back();
        } else {
          updating.value = false;
          AppHelper.throwError(error: status.message ?? "");
        }
      } else {
        updating.value = false;
        AppHelper.throwError(error: result.error ?? "");
      }
    }
  }

  @override
  void onInit() {
    getAllOrders();
    super.onInit();
  }
}
