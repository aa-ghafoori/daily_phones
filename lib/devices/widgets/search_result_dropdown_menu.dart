import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/devices/bloc/devices_bloc.dart';
import 'package:daily_phones/repair/bloc/repair_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';

class SearchResultDropdownMenu extends StatelessWidget {
  final bool isFocused;
  final List<Product> products;

  const SearchResultDropdownMenu({
    required this.isFocused,
    required this.products,
    super.key,
  });

  void _onProductClicked(Product product, BuildContext context) {
    context.navigator.pushNamed('/repair');
    context.read<RepairBloc>().add(RepairProductSelected(product: product));
    Future.delayed(const Duration(milliseconds: 50),
        () => context.read<DevicesBloc>().focusNode.unfocus());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      duration: Durations.short3,
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onBackground.withOpacity(0.2),
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
          child: Column(
            children: products
                .map(
                  (product) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _onProductClicked(product, context),
                    child: _DropDownMenuItem(
                      brandName: product.brand,
                      description: product.name,
                    ),
                  ),
                )
                .toList(),
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
                    fontWeight: FontWeight.w400),
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
