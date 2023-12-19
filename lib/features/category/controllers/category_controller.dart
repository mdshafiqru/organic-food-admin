import 'dart:convert';

import 'package:get/get.dart';
import 'package:organic_foods_admin/features/category/repo/category_repo.dart';

import '../../../constants/app_helper.dart';
import '../../../models/data_result.dart';
import '../../../models/product_category.dart';
import '../../../models/response_status.dart';

class CategoryController extends GetxController {
  var categories = <ProductCategory>[].obs;
  var loading = false.obs;
  var creating = false.obs;

  String newCategoryName = "";

  getCategories() async {
    loading.value = true;
    final DataResult dataResult = await CategoryRepo.getCategories();

    if (dataResult.error == null) {
      final categoryList = dataResult.data != null ? dataResult.data as List<ProductCategory> : <ProductCategory>[];

      categories.clear();
      for (var item in categoryList) {
        categories.add(item);
      }
    }
    loading.value = false;
  }

  createCategory() async {
    if (!creating.value) {
      creating.value = true;

      final body = jsonEncode({
        "name": newCategoryName,
      });

      final result = await CategoryRepo.createCategory(body);

      if (result.error == null) {
        final status = result.data != null ? result.data as ResponseStatus : ResponseStatus();

        bool success = status.success ?? false;

        if (success) {
          getCategories();
          creating.value = false;
          AppHelper.showToast(message: status.message ?? "");
        } else {
          creating.value = false;
          AppHelper.throwError(error: status.message ?? "");
        }
      } else {
        creating.value = false;
        AppHelper.throwError(error: result.error ?? "");
      }
    }
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
}
