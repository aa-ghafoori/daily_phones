import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RepairOptionsShimmer extends StatelessWidget {
  const RepairOptionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          6,
          (index) => Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.h,
                              color: Colors.white,
                            ),
                            const WhiteSpace(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 20.h,
                                  color: Colors.white,
                                ),
                                const WhiteSpace(height: 5),
                                Container(
                                  width: 60.w,
                                  height: 10.h,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        const WhiteSpace(height: 15),
                        Container(
                          width: double.infinity,
                          height: 20.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 60.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
