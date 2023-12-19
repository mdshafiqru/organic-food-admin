import 'package:flutter/material.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';

class AppInfoView extends StatelessWidget {
  const AppInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("অ্যাপ ইনফরমেশন"),
    );
  }
}
