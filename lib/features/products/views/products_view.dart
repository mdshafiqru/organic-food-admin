import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/features/category/controllers/category_controller.dart';
import 'package:organic_foods_admin/features/products/controllers/product_controller.dart';
import 'package:organic_foods_admin/features/products/views/create_product_view.dart';
import 'package:organic_foods_admin/features/products/widgets/product_card.dart';
import 'package:organic_foods_admin/models/product.dart';
import 'package:organic_foods_admin/widgets/loader.dart';

class ProductsView extends StatelessWidget {
  ProductsView({super.key});

  final _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar(
        "প্রডাক্ট সমূহ",
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CreateProductView(), transition: Transition.zoom);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: Obx(() {
            final loading = Get.find<ProductController>().loading.value;
            final products = Get.find<ProductController>().products;
            return loading
                ? const Loader()
                : products.isEmpty
                    ? Center(
                        child: Text(
                          "কোনো প্রডাক্ট পাওয়া যায় নি",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      )
                    : ListView(
                        children: [
                          Wrap(
                            children: List.generate(products.length, (index) {
                              final Product product = products[index];
                              return ProductCard(product: product);
                            }),
                          ),
                        ],
                      );
          }),
        ),
      ),
    );
  }
}
