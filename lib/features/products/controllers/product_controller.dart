import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/features/products/repo/product_repo.dart';

import '../../../models/data_result.dart';
import '../../../models/product.dart';
import '../../../models/response_status.dart';

class ProductController extends GetxController {
  final _imagePicker = ImagePicker();
  var products = <Product>[].obs;
  var loading = false.obs;
  var creating = false.obs;

  var selectedCategoryId = "";
  var imagePath = "".obs;
  String name = "";
  String size = "";
  double price = 0;
  String shortDesc = "";
  String longDesc = "";

  selectImage() async {
    var pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    } else {
      Get.snackbar(
        "Not selected",
        "No image selected.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  createProduct() async {
    if (selectedCategoryId.isEmpty) {
      return AppHelper.showToast(message: "ক্যাটাগরি সিলেক্ট করুন");
    }
    if (imagePath.isEmpty) {
      return AppHelper.showToast(message: "ছবি সিলেক্ট করুন");
    }

    if (!creating.value) {
      creating.value = true;

      List<String> images = [imagePath.value];

      Product product = Product()
        ..name = name
        ..size = size
        ..price = price
        ..shortDesc = shortDesc
        ..longDesc = longDesc
        ..categoryId = selectedCategoryId;

      final result = await ProductRepo.createProduct(product, images);

      if (result.error == null) {
        final status = result.data != null ? result.data as ResponseStatus : ResponseStatus();

        bool success = status.success ?? false;

        if (success) {
          getProducts();
          creating.value = false;
          AppHelper.showToast(message: status.message ?? "");
          Get.back();
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

  getProducts() async {
    loading.value = true;

    final DataResult dataResult = await ProductRepo.getProducts();

    if (dataResult.error == null) {
      final productList = dataResult.data != null ? dataResult.data as List<Product> : <Product>[];

      products.clear();
      for (var item in productList) {
        products.add(item);
      }
    }
    loading.value = false;
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
