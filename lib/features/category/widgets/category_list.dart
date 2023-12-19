import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/app_colors.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';

import '../../../models/product_category.dart';
import '../../../widgets/loader.dart';
import '../controllers/category_controller.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "সকল ক্যাটাগরি",
          style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.w),
        Obx(() {
          final categories = Get.find<CategoryController>().categories;
          bool loading = Get.find<CategoryController>().loading.value;
          return loading
              ? const Loader()
              : Wrap(
                  children: List.generate(categories.length, (index) {
                    final ProductCategory category = categories[index];
                    return InkWell(
                      child: Card(
                        child: SizedBox(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                            child: Text(
                              category.name ?? "",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
        }),
      ],
    );
  }
}
