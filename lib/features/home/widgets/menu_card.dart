import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Text(
            text,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
