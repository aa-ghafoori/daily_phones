import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultDropdownMenu extends StatelessWidget {
  const SearchResultDropdownMenu({
    required this.isFocused,
    required this.products,
    super.key,
  });

  final bool isFocused;
  final List<Product> products;

  void _onProductClicked(Product product, BuildContext context) =>
      context.navigator.pushNamed(RepairScreen.routeName, arguments: product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        clipBehavior: Clip.hardEdge,
        duration: Durations.short3,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.onSurface.withOpacity(0.2),
              offset: const Offset(0, 5),
              blurRadius: 3,
            ),
          ],
        ),
        height: isFocused ? 0.3.sh : 0,
        margin: isFocused
            ? EdgeInsets.zero
            : EdgeInsets.only(left: 80.w, right: 120.w),
        child: Scrollbar(
          trackVisibility: true,
          radius: Radius.circular(15.r),
          thickness: 8.w,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(), // Prevent overscroll
            child: Column(
              children: products
                  .map(
                    (product) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _onProductClicked(product, context),
                      child: _DropDownMenuItem(
                        brandName: product.brand.name,
                        description: product.name,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropDownMenuItem extends StatelessWidget {
  const _DropDownMenuItem({required this.brandName, required this.description});

  final String brandName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 0,
          height: 0,
        ),
        Padding(
          padding: EdgeInsets.all(15.w),
          child: Row(
            children: [
              Text(
                brandName,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  description,
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
