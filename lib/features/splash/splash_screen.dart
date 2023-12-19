import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/features/auth/views/signin_view.dart';
import 'package:organic_foods_admin/features/home/views/home_view.dart';

import '../../widgets/loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  gotoHome() {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      if (AppHelper.isLoggedIn) {
        Get.offAll(() => const HomeView());
      } else {
        Get.offAll(() => const SigninView());
      }
    });
  }

  @override
  void initState() {
    gotoHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Loader(),
      ),
    );
  }
}
