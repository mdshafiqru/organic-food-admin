import 'package:flutter/material.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';

class SlidersView extends StatelessWidget {
  const SlidersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("স্লাইডারস"),
    );
  }
}
