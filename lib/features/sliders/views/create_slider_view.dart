import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/app_colors.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/features/sliders/controllers/slider_controller.dart';
import 'package:organic_foods_admin/widgets/custom_button.dart';

class CreateSliderView extends StatelessWidget {
  const CreateSliderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("নতুন স্লাইডার ইমেজ আপলোড"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: ListView(
            children: [
              CustomButton(
                text: "Choose Image",
                onPressed: () {
                  Get.find<SliderController>().selectImage();
                },
                loading: false,
              ),
              SizedBox(height: 10.w),
              Obx(() {
                final controller = Get.find<SliderController>();
                final path = controller.imagePath.value;
                bool loading = controller.creating.value;

                return path.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          Container(
                            height: 200.w,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.w, color: AppColors.textColor4),
                              image: DecorationImage(
                                image: FileImage(File(path)),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.w),
                          CustomButton(
                            text: "Save",
                            onPressed: () {
                              controller.createSlider();
                            },
                            loading: loading,
                          )
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
