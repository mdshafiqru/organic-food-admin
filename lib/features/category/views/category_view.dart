import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/features/category/controllers/category_controller.dart';
import 'package:organic_foods_admin/models/product_category.dart';
import 'package:organic_foods_admin/widgets/loader.dart';

import '../widgets/category_list.dart';
import '../widgets/create_category_card.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  final _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("ক্যাটাগরি"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreateCategoryCard(),
              SizedBox(height: 20.w),
              CategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}
