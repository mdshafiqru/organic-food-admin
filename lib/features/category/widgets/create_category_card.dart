import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/app_colors.dart';
import 'package:organic_foods_admin/features/category/controllers/category_controller.dart';
import 'package:organic_foods_admin/widgets/custom_button.dart';

class CreateCategoryCard extends StatefulWidget {
  const CreateCategoryCard({
    super.key,
  });

  @override
  State<CreateCategoryCard> createState() => _CreateCategoryCardState();
}

class _CreateCategoryCardState extends State<CreateCategoryCard> {
  final _nameController = TextEditingController();

  final _createKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0.w),
        child: Form(
          key: _createKey,
          child: Column(
            children: [
              Text(
                "নতুন ক্যাটাগরি তৈরি করুন",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textGreenColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                style: TextStyle(fontSize: 15.sp),
                decoration: const InputDecoration(
                  labelText: "ক্যাটাগরির নাম",
                ),
                controller: _nameController,
                onChanged: (value) {
                  Get.find<CategoryController>().newCategoryName = value;
                },
                validator: RequiredValidator(errorText: "নাম দিতে হবে"),
              ),
              SizedBox(height: 20.w),
              Obx(() {
                bool loading = Get.find<CategoryController>().creating.value;
                return CustomButton(
                  text: "সেভ করুন",
                  onPressed: () {
                    if (_createKey.currentState != null) {
                      if (_createKey.currentState!.validate()) {
                        Get.find<CategoryController>().createCategory();
                      }
                    }
                  },
                  loading: loading,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
