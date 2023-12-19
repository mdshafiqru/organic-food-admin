import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organic_foods_admin/constants/api_endpoints.dart';
import 'package:organic_foods_admin/constants/app_helper.dart';
import 'package:organic_foods_admin/features/sliders/controllers/slider_controller.dart';
import 'package:organic_foods_admin/features/sliders/views/create_slider_view.dart';
import 'package:organic_foods_admin/widgets/loader.dart';

class SlidersView extends StatelessWidget {
  SlidersView({super.key});

  final _sliderController = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar(
        "স্লাইডারস",
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CreateSliderView(), transition: Transition.zoom);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: Obx(() {
            final controller = Get.find<SliderController>();
            final sliders = controller.sliders;
            final bool loading = controller.loading.value;
            return loading
                ? const Loader()
                : ListView(
                    children: List.generate(sliders.length, (index) {
                      final slider = sliders[index];
                      String image = slider.image ?? "";
                      String imgUrl = image.isNotEmpty ? ApiEndPoints.rootUrl + image : image;
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.w),
                        child: Dismissible(
                          key: Key(slider.id ?? ""),
                          onDismissed: (direction) {
                            Get.find<SliderController>().deleteSlider(id: slider.id ?? "", index: index);
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16.0),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: Container(
                            height: 200.w,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              image: DecorationImage(
                                image: NetworkImage(imgUrl),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
          }),
        ),
      ),
    );
  }
}
