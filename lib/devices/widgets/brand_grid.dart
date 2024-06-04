import 'package:daily_phones/core/common/widgets/description.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/devices/bloc/devices_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';

class BrandGrid extends StatelessWidget {
  const BrandGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevicesBloc, DevicesState>(
      buildWhen: (previous, current) => current is DevicesBrandsLoadSuccess,
      builder: (context, state) {
        if (state is DevicesBrandsLoadSuccess) {
          return BrandGridView(brands: state.brands);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class BrandGridView extends StatelessWidget {
  const BrandGridView({required this.brands, super.key});

  final List<Brand> brands;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Column(
        children: [
          const Description(
            text1: 'Of selecteer het',
            text2: 'merk',
          ),
          const WhiteSpace(height: 10),
          GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13.r,
                mainAxisSpacing: 13.r,
                childAspectRatio: 1.5,
              ),
              children: brands
                  .map(
                    (brand) => Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.background,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 0,
                            color: context.colorScheme.onBackground
                                .withOpacity(0.1),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        brand.imageUrl,
                        scale: 4,
                      ),
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}
