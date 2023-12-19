import 'package:flutter/material.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("প্রোডাক্ট সমূহ"),
    );
  }
}
