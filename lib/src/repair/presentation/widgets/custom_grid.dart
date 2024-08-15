import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairBloc, RepairState>(
      builder: (context, state) {
        if (state is RepairProductTypesLoadSuccess) {
          return CustomGridView(
            gridItems:
                state.productTypes.map(GridItem.fromProductType).toList(),
            isType: true,
            onTap: (gridItem) => context.read<RepairBloc>().add(
                  RepairProductTypeSelected(gridItem.ancestor as ProductType),
                ),
          );
        }
        if (state is RepairBrandsLoadSuccess) {
          return CustomGridView(
            gridItems: state.brands.map(GridItem.fromBrand).toList(),
          );
        }
        return const GridShimmer();
      },
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    required this.gridItems,
    this.isType = false,
    this.onTap,
    super.key,
  });

  final List<GridItem> gridItems;

  final bool isType;

  final void Function(GridItem)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Column(
        children: [
          Description(
            text1: 'Of selecteer het',
            text2: isType ? 'type' : 'merk',
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
            children: gridItems.map(
              (gridItem) {
                return GestureDetector(
                  onTap: () => onTap?.call(gridItem),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: context.colorScheme.onSurface.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          gridItem.imageUrl,
                          scale: isType ? 6 : 4,
                        ),
                        if (isType) ...[
                          const WhiteSpace(height: 10),
                          Text(
                            gridItem.name.toUpperCase(),
                            style: context.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
