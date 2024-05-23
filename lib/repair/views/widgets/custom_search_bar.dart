import 'package:daily_phones/core/res/constants.dart';
import 'package:daily_phones/repair/app/search_bar_provider.dart';
import 'package:daily_phones/repair/views/widgets/grid_list.dart';
import 'package:daily_phones/select_repairs/app/list_key_provider.dart';
import 'package:daily_phones/select_repairs/app/product_provider.dart';
import 'package:daily_phones/select_repairs/views/select_repairs_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({super.key});

  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();
  late List<SmartphoneBrand> _filteredList;

  @override
  void initState() {
    super.initState();
    _filteredList = smartphoneBrands;
    _focusNode.addListener(_onFocusChange);
    ref.read(searchBarNotifierProvider.notifier).setFocusNode(_focusNode);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    ref.read(searchBarNotifierProvider.notifier).setFocus(_focusNode.hasFocus);
  }

  void _handleTextChanged(String value) {
    setState(() {
      _filteredList = smartphoneBrands
          .where((element) =>
              element.brand.toLowerCase().contains(value.toLowerCase()) ||
              element.products
                  .where(
                      (e) => e.name.toLowerCase().contains(value.toLowerCase()))
                  .isNotEmpty)
          .toList();
    });
  }

  void _onProductClicked(Product product) {
    ref.read(productNotifierProvider.notifier).setProduct(product, ref);
    ref.read(listKeyProvider.notifier).refreshKey();
    navigateToSelectRepairsScreen();
    _focusNode.unfocus();
    ref.watch(productNotifierProvider);
    ref.watch(listKeyProvider);
  }

  void navigateToSelectRepairsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectRepairsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = ref.watch(searchBarNotifierProvider);

    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              decoration: BoxDecoration(
                color: context.colorScheme.onBackground.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 13,
                        color: context.colorScheme.secondary,
                      ),
                      const WhiteSpace(width: 5),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            style: context.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w300),
                            text: 'Voer het ',
                            children: [
                              TextSpan(
                                text: 'merk, model',
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const TextSpan(text: ' of '),
                              TextSpan(
                                text: 'modelcode',
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const TextSpan(text: ' in.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const WhiteSpace(height: 70),
                ],
              ),
            ),
            const GridList(),
          ],
        ),
        Positioned(
          top: 68.h,
          left: 15.w,
          right: 10.w,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.background,
                        borderRadius: isFocused
                            ? BorderRadius.only(
                                topLeft: Radius.circular(15.r),
                                topRight: Radius.circular(15.r))
                            : BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color:
                                context.colorScheme.secondary.withOpacity(0.2),
                            blurStyle: BlurStyle.outer,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: TextField(
                        focusNode: _focusNode,
                        onChanged: _handleTextChanged,
                        cursorColor: context.colorScheme.onBackground,
                        cursorWidth: 1,
                        style: context.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          suffixIconConstraints:
                              const BoxConstraints(minHeight: 0),
                          suffixIcon: AnimatedSwitcher(
                            switchOutCurve: Curves.easeIn,
                            switchInCurve: Curves.easeOut,
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              if (child.key == const ValueKey(1)) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              } else {
                                return RotationTransition(
                                  turns: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                );
                              }
                            },
                            child: !isFocused
                                ? Container(
                                    key: const ValueKey<int>(1),
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 9),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: context.colorScheme.secondary
                                          .withOpacity(0.22),
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      color: context.colorScheme.secondary,
                                      size: 25,
                                    ),
                                  )
                                : Padding(
                                    key: const ValueKey<int>(2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        _focusNode.unfocus();
                                      },
                                      child: Icon(
                                        CupertinoIcons.xmark_circle_fill,
                                        size: 30,
                                        color: context.colorScheme.onBackground
                                            .withOpacity(0.45),
                                      ),
                                    ),
                                  ),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: context.colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.r),
                                topRight: Radius.circular(15.r)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!isFocused)
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        SvgPicture.asset(
                          ImageRes.phone,
                          height: 48.h,
                          colorFilter: ColorFilter.mode(
                            context.colorScheme.secondary.withOpacity(0.7),
                            BlendMode.srcIn,
                          ),
                        ),
                        SvgPicture.asset(
                          ImageRes.question,
                          height: 17,
                          colorFilter: ColorFilter.mode(
                            context.colorScheme.secondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              AnimatedContainer(
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
                  child: SingleChildScrollView(
                    child: Column(
                        children: _filteredList
                            .expand(
                              (brand) => brand.products.map(
                                (product) => GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () => _onProductClicked(Product(
                                      name: product.name,
                                      colors: product.colors,
                                      brand: brand.brand)),
                                  child: _DropDownMenuItem(
                                    brandName: brand.brand,
                                    description: product.name,
                                  ),
                                ),
                              ),
                            )
                            .toList()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DropDownMenuItem extends StatelessWidget {
  final String brandName;
  final String description;

  const _DropDownMenuItem({
    required this.brandName,
    required this.description,
  });

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
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.secondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  description,
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
