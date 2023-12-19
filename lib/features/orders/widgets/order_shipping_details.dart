import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../models/address.dart';
import '../../../models/order.dart';

class OrderShippingDetails extends StatelessWidget {
  const OrderShippingDetails({
    super.key,
    required this.order,
    required this.address,
  });

  final Order order;
  final Address address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "প্রাপকের তথ্য",
          style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.bold),
        ),
        Text(
          order.receiverName ?? "",
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textColor1,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          order.phone ?? "",
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textColor1,
            fontWeight: FontWeight.w500,
          ),
        ),
        Wrap(
          children: [
            Text(
              "${address.location ?? ""}, ",
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.textColor1,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${address.thana ?? ""}, ",
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.textColor1,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${address.district ?? ""}, ",
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.textColor1,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "বিভাগঃ ${address.division?.name ?? ""}",
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.textColor1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
