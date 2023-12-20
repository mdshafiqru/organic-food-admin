import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/widgets/unfocus_ontap.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../controller/order_controller.dart';

class UpdateOrderStatusView extends StatefulWidget {
  const UpdateOrderStatusView({super.key, required this.orderId});

  final String orderId;

  @override
  State<UpdateOrderStatusView> createState() => _UpdateOrderStatusViewState();
}

class _UpdateOrderStatusViewState extends State<UpdateOrderStatusView> {
  final _statusKey = GlobalKey<FormState>();

  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusList = Get.find<OrderController>().statusList;
    return UnfocusOnTap(
      child: Scaffold(
        appBar: AppHelper.commonAppbar("আপডেট অর্ডার স্ট্যাটাস"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.w),
                DropdownSearch(
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: TextStyle(fontSize: 14.sp),
                  ),
                  items: statusList,
                  selectedItem: "Select Order Status",
                  onChanged: (name) {
                    Get.find<OrderController>().selectedStatus.value = name ?? "";
                  },
                ),
                SizedBox(height: 10.w),
                Form(
                  key: _statusKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(fontSize: 15.sp),
                        decoration: InputDecoration(
                          labelText: "Comment",
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12.w),
                        ),
                        controller: _reasonController,
                        onChanged: (value) {
                          Get.find<OrderController>().reason = value;
                        },
                      ),
                      SizedBox(height: 10.w),
                      Obx(() {
                        bool loading = Get.find<OrderController>().updating.value;
                        return CustomButton(
                          text: "Update",
                          onPressed: () {
                            if (_statusKey.currentState != null) {
                              if (_statusKey.currentState!.validate()) {
                                Get.find<OrderController>().updateOrderStatus(widget.orderId);
                              }
                            }
                          },
                          loading: loading,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
