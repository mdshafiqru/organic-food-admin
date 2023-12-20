import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/features/app_info/views/app_info_view.dart';
import 'package:organic_foods_admin/features/category/views/category_view.dart';
import 'package:organic_foods_admin/features/orders/view/orders_view.dart';
import 'package:organic_foods_admin/features/products/views/products_view.dart';
import 'package:organic_foods_admin/features/sliders/views/sliders_view.dart';

import '../widgets/menu_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("Admin"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: ListView(
            children: [
              MenuCard(
                text: 'অর্ডার ',
                onTap: () {
                  Get.to(() => const OrdersView());
                },
              ),
              MenuCard(
                text: 'প্রডাক্ট ',
                onTap: () {
                  Get.to(() => ProductsView());
                },
              ),
              MenuCard(
                text: 'ক্যাটাগরি',
                onTap: () {
                  Get.to(() => CategoryView());
                },
              ),
              MenuCard(
                text: 'অ্যাপ ইনফরমেশন',
                onTap: () {
                  Get.to(() => const AppInfoView());
                },
              ),
              MenuCard(
                text: 'স্লাইডারস',
                onTap: () {
                  Get.to(() => SlidersView());
                },
              ),
              MenuCard(
                text: 'লগ আউট',
                onTap: () {
                  AppHelper.confirmLogout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
