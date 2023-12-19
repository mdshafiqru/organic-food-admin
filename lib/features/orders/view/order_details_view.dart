import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/features/orders/view/update_order_status_view.dart';
import 'package:organic_foods_admin/widgets/custom_button.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_helper.dart';
import '../../../constants/status.dart';
import '../../../models/address.dart';
import '../../../models/order.dart';
import '../../../models/order_item.dart';
import '../../../models/product.dart';
import '../widgets/change_order_status_button.dart';
import '../widgets/order_item_details.dart';
import '../widgets/order_shipping_details.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key, required this.order, required this.statusColor});

  final Order order;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("অর্ডারের বিস্তারিত"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: ListView(
            children: [
              _orderId(),
              SizedBox(height: 10.w),
              if (order.status == Status.rejected || order.status == Status.cancelled) _reason(),
              OrderShippingDetails(order: order, address: order.address ?? Address()),
              SizedBox(height: 10.w),
              _orderItems(context),
              SizedBox(height: 20.w),
              _statusButton()
            ],
          ),
        ),
      ),
    );
  }

  CustomButton _statusButton() {
    return CustomButton(
      text: "অর্ডার স্ট্যাটাস আপডেট করুন",
      onPressed: () {
        Get.to(
          () => UpdateOrderStatusView(orderId: order.id ?? ""),
          transition: Transition.zoom,
        );
      },
      loading: false,
    );
  }

  Widget _orderItems(BuildContext context) {
    final orderItems = order.orderItems ?? <OrderItem>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "পণ্য সমুহ",
          style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(orderItems.length, (index) {
            final item = orderItems[index];

            int qty = item.qty ?? 0;
            double price = item.price ?? 0;
            double total = item.total ?? 0;

            final Product product = item.product ?? Product();
            final String image = product.image ?? "";
            final String imageUrl = image.isNotEmpty ? ApiEndPoints.rootUrl + image : "";

            return InkWell(
              onTap: () {
                _showItemDetails(context, item);
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final imageProvider = Image.network(imageUrl).image;
                        showImageViewer(
                          context,
                          imageProvider,
                          doubleTapZoomable: true,
                        );
                      },
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? "",
                            style: TextStyle(fontSize: 15.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 10.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$qty X ${AppHelper.getNumberFormated(price)}",
                                style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                              ),
                              Text(
                                "${AppHelper.getNumberFormated(total)}",
                                style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "মোট",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Text(
                        "${AppHelper.getNumberFormated(order.orderAmount ?? 0)}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textColor1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ডেলিভারি চার্জ ",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Text(
                        "${AppHelper.getNumberFormated(order.deliveryCharge ?? 0)}",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "সর্বোমোটঃ ",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Text(
                        "৳ ${AppHelper.getNumberFormated(order.grandTotal ?? 0)}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGreenColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // Text("In Words: ${AppHelper.numberToWordsWithCurrency(order.grandTotal ?? 0, "Tk")}"),
      ],
    );
  }

  Widget _reason() {
    String text = "";
    if (order.status == Status.rejected) {
      text = "বাতিল করার কারনঃ ${order.reason}";
    } else if (order.status == Status.cancelled) {
      text = "ক্যান্সেল করার কারনঃ ${order.reason}";
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: Text(text),
    );
  }

  Widget _orderId() {
    return Wrap(
      children: [
        Text(
          "Invoice No: ",
          style: TextStyle(fontSize: 15.sp),
        ),
        GestureDetector(
          onTap: () {
            AppHelper.copyToClipboard(text: order.invoiceId ?? "");
          },
          child: Text(
            "# ${order.invoiceId ?? ""}",
            style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "  ( ${order.status ?? ""} )",
          style: TextStyle(fontSize: 15.sp, color: statusColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _showItemDetails(BuildContext context, OrderItem item) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          height: 400.w,
          child: OrderItemDetail(item: item),
        );
      },
    );
  }
}
