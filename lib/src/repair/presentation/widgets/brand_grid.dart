import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandGrid extends StatelessWidget {
  const BrandGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairBloc, RepairState>(
      buildWhen: (previous, current) => current is RepairBrandsLoadSuccess,
      builder: (context, state) {
        if (state is RepairBrandsLoadSuccess) {
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
