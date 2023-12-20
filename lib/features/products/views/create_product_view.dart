import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/features/products/controllers/product_controller.dart';
import 'package:organic_foods_admin/models/product_category.dart';
import 'package:organic_foods_admin/widgets/custom_button.dart';
import 'package:organic_foods_admin/widgets/unfocus_ontap.dart';

import '../../../constants/app_colors.dart';
import '../../category/controllers/category_controller.dart';

class CreateProductView extends StatefulWidget {
  const CreateProductView({super.key});

  @override
  State<CreateProductView> createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  final _categoryController = Get.put(CategoryController());

  final _createKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();
  final _priceController = TextEditingController();
  final _shortDescController = TextEditingController();
  final _longDescController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sizeController.dispose();
    _priceController.dispose();
    _shortDescController.dispose();
    _longDescController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusOnTap(
      child: Scaffold(
        appBar: AppHelper.commonAppbar("নতুন প্রডাক্ট তৈরি করুন"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Form(
              key: _createKey,
              child: ListView(
                children: [
                  SizedBox(height: 10.w),
                  _category(),
                  SizedBox(height: 10.w),
                  _name(),
                  SizedBox(height: 10.w),
                  _size(),
                  SizedBox(height: 10.w),
                  _price(),
                  SizedBox(height: 10.w),
                  _shortDesc(),
                  SizedBox(height: 10.w),
                  _longDesc(),
                  SizedBox(height: 10.w),
                  _image(),
                  SizedBox(height: 10.w),
                  _saveButton(),
                  SizedBox(height: 10.w),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Obx _saveButton() {
    return Obx(() {
      bool loading = Get.find<ProductController>().creating.value;
      return CustomButton(
        text: "Save",
        onPressed: () {
          if (_createKey.currentState != null) {
            if (_createKey.currentState!.validate()) {
              Get.find<ProductController>().createProduct();
            }
          }
        },
        loading: loading,
      );
    });
  }

  Widget _image() {
    return Obx(() {
      final controller = Get.find<ProductController>();
      String path = controller.imagePath.value;
      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              controller.selectImage();
            },
            child: Text(
              "ছবি সিলেক্ট করুন",
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
          if (path.isNotEmpty) SizedBox(height: 10.w),
          if (path.isNotEmpty)
            Container(
              height: 200.w,
              decoration: BoxDecoration(
                // border: Border.all(width: 1.w, color: AppColors.textColor4),
                image: DecorationImage(
                  image: FileImage(File(path)),
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      );
    });
  }

  TextFormField _longDesc() {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12.w),
        labelText: "বিস্তারিত বর্ণনা",
        labelStyle: TextStyle(fontSize: 14.sp),
      ),
      maxLines: 6,
      controller: _longDescController,
      onChanged: (value) {
        Get.find<ProductController>().longDesc = value;
      },
    );
  }

  TextFormField _shortDesc() {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12.w),
        labelText: "সংক্ষিপ্ত বর্ণনা",
        labelStyle: TextStyle(fontSize: 14.sp),
      ),
      maxLines: 2,
      controller: _shortDescController,
      onChanged: (value) {
        Get.find<ProductController>().shortDesc = value;
      },
    );
  }

  TextFormField _price() {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12.w),
        labelText: "মূল্য / দাম (৳)",
        labelStyle: TextStyle(fontSize: 14.sp),
        hintText: "৩০০",
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
      controller: _priceController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          Get.find<ProductController>().price = double.parse(value);
        } else {
          Get.find<ProductController>().price = 0;
        }
      },
      validator: RequiredValidator(errorText: "প্রডাক্টের মূল্য / দাম দিতে হবে"),
    );
  }

  TextFormField _size() {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12.w),
        labelText: "সাইজ",
        labelStyle: TextStyle(fontSize: 14.sp),
        hintText: "২৫০ গ্রাম / ১ কেজি",
      ),
      controller: _sizeController,
      onChanged: (value) {
        Get.find<ProductController>().size = value;
      },
      validator: RequiredValidator(errorText: "প্রডাক্টের সাইজ দিতে হবে"),
    );
  }

  TextFormField _name() {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12.w),
        labelText: "প্রডাক্টের নাম",
        labelStyle: TextStyle(fontSize: 14.sp),
      ),
      controller: _nameController,
      onChanged: (value) {
        Get.find<ProductController>().name = value;
      },
      validator: RequiredValidator(errorText: "প্রডাক্টের নাম দিতে হবে"),
    );
  }

  Obx _category() {
    return Obx(() {
      var categories = Get.find<CategoryController>().categories;

      var names = [];

      for (var item in categories) {
        names.add(item.name ?? "");
      }

      return DropdownSearch(
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              // border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12.w),
              hintText: "সার্চ করুন",
            ),
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize: 14.sp),
          dropdownSearchDecoration: InputDecoration(
            labelText: 'ক্যাটাগরি',
            labelStyle: TextStyle(fontSize: 14.sp),
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.all(12.w),
          ),
        ),
        items: names,
        selectedItem: "ক্যাটাগরি সিলেক্ট করুন",
        onChanged: (name) {
          final controller = Get.find<ProductController>();
          String selectedId = "";

          for (var item in categories) {
            if (item.name == name) {
              //
              selectedId = item.id ?? "";

              break;
            }
          }
          controller.selectedCategoryId = selectedId;
        },
      );
    });
  }
}
