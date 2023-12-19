import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organic_foods_admin/features/sliders/repo/slider_repo.dart';

import '../../../constants/app_helper.dart';
import '../../../models/app_slider.dart';
import '../../../models/data_result.dart';
import '../../../models/response_status.dart';

class SliderController extends GetxController {
  final _imagePicker = ImagePicker();

  var sliders = <AppSlider>[].obs;

  var loading = false.obs;
  var creating = false.obs;

  var deleting = false.obs;

  var imagePath = "".obs;

  createSlider() async {
    if (!creating.value) {
      creating.value = true;

      List<String> images = [imagePath.value];

      final result = await SliderRepo.createSlider(images);

      if (result.error == null) {
        final status = result.data != null ? result.data as ResponseStatus : ResponseStatus();

        bool success = status.success ?? false;

        if (success) {
          getAppSliders();
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

  selectImage() async {
    var pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      print(imagePath.value);
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

  deleteSlider({required String id, required int index}) async {
    if (!deleting.value) {
      deleting.value = true;

      final result = await SliderRepo.deleteSlider(id);

      if (result.error == null) {
        final status = result.data != null ? result.data as ResponseStatus : ResponseStatus();

        bool success = status.success ?? false;

        if (success) {
          sliders.removeAt(index);

          deleting.value = false;
          AppHelper.showToast(message: status.message ?? "");
        } else {
          deleting.value = false;
          AppHelper.throwError(error: status.message ?? "");
        }
      } else {
        deleting.value = false;
        AppHelper.throwError(error: result.error ?? "");
      }
    }
  }

  getAppSliders() async {
    final DataResult dataResult = await SliderRepo.getSliders();

    if (dataResult.error == null) {
      final sliderList = dataResult.data != null ? dataResult.data as List<AppSlider> : <AppSlider>[];
      sliders.clear();
      for (var item in sliderList) {
        sliders.add(item);
      }
    }
  }

  @override
  void onInit() {
    getAppSliders();
    super.onInit();
  }
}
