import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/features/products/controllers/product_controller.dart';
import 'package:organic_foods_admin/features/products/repo/product_repo.dart';
import 'package:organic_foods_admin/models/product_category.dart';

import '../../../models/data_result.dart';
import '../../../models/product.dart';
import '../../../models/response_status.dart';

class EditProductController extends GetxController {
  final _imagePicker = ImagePicker();

  var category = ProductCategory().obs;

  var updating = false.obs;

  var selectedCategoryId = "";
  var imagePath = "".obs;
  var oldImage = "".obs;
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

  updateProduct() async {
    if (selectedCategoryId.isEmpty) {
      return AppHelper.showToast(message: "ক্যাটাগরি সিলেক্ট করুন");
    }
    if (imagePath.isEmpty) {
      return AppHelper.showToast(message: "ছবি সিলেক্ট করুন");
    }

    if (!updating.value) {
      updating.value = true;

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
          Get.find<ProductController>().getProducts();
          updating.value = false;
          AppHelper.showToast(message: status.message ?? "");
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
}
