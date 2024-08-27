import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    late ProductType selectedType;
    return BlocBuilder<RepairBloc, RepairState>(
      builder: (context, state) {
        if (state is RepairLoadInProgress) {
          return const GridShimmer();
        }

        if (state is RepairLoadSuccess) {
          if (state.productTypes != null && state.brands == null) {
            return CustomGridView(
              gridItems:
                  state.productTypes!.map(GridItem.fromProductType).toList(),
              isType: true,
              onTap: (gridItem) {
                selectedType = gridItem.ancestor as ProductType;
                context.read<RepairBloc>().add(
                      RepairProductTypeSelected(selectedType),
                    );
              },
            );
          } else if (state.brands != null && state.filteredProducts == null) {
            return CustomGridView(
              gridItems: state.brands!.map(GridItem.fromBrand).toList(),
              onTap: (gridItem) => context.read<RepairBloc>().add(
                    RepairBrandSelected(
                      brand: gridItem.ancestor as Brand,
                      type: selectedType,
                    ),
                  ),
            );
          } else if (state.filteredProducts != null) {
            return CustomGridView(
              gridItems:
                  state.filteredProducts!.map(GridItem.fromProduct).toList(),
              isProduct: true,
              onTap: (gridItem) => context.navigator.pushNamed(
                RepairScreen.routeName,
                arguments: gridItem.ancestor as Product,
              ),
            );
          }
        }

        if (state is RepairLoadFailure) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    color: context.colorScheme.tertiary,
                    size: 80.h,
                  ),
                  const WhiteSpace(height: 20),
                  Text(
                    'No products found.',
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const WhiteSpace(height: 10),
                  Text(
                    'Go back or try selecting different models.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                  const WhiteSpace(height: 30),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    required this.gridItems,
    this.isType = false,
    this.isProduct = false,
    this.onTap,
    super.key,
  });

  final List<GridItem> gridItems;

  final bool isType;

  final bool isProduct;

  final void Function(GridItem)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Column(
        children: [
          Description(
            text1: 'Of selecteer het',
            text2: isType
                ? 'type'
                : isProduct
                    ? 'model'
                    : 'merk',
          ),
          const WhiteSpace(height: 20),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13.r,
              mainAxisSpacing: 13.r,
              childAspectRatio: isProduct ? 0.85 : 1.5,
            ),
            children: gridItems.map(
              (gridItem) {
                return GestureDetector(
                  onTap: () => onTap?.call(gridItem),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(15.r),
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
                          scale: isType
                              ? 6 * (1 / 1.h)
                              : isProduct
                                  ? 10 * (1 / 1.h)
                                  : 4 * (1 / 1.h),
                        ),
                        if (isType || isProduct) ...[
                          WhiteSpace(height: isProduct ? 20 : 10),
                          Text(
                            isProduct
                                ? gridItem.name
                                : gridItem.name.toUpperCase(),
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight:
                                  isProduct ? FontWeight.w500 : FontWeight.w400,
                            ),
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
