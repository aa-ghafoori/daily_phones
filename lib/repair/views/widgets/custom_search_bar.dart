import 'package:daily_phones/core/res/constants.dart';
import 'package:daily_phones/repair/app/search_bar_provider.dart';
import 'package:daily_phones/repair/views/widgets/grid_list.dart';
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
    ref.read(productNotifierProvider.notifier).setProduct(product);
    navigateToSelectRepairsScreen();
    _focusNode.unfocus();
    ref.watch(productNotifierProvider);
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
            _SearchBar(
              focusNode: _focusNode,
              isFocused: isFocused,
              onTextChanged: _handleTextChanged,
            ),
            const GridList(),
          ],
        ),
        if (isFocused)
          _SearchResults(
            onProductClicked: _onProductClicked,
            filteredList: _filteredList,
          ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final FocusNode focusNode;
  final bool isFocused;
  final Function(String) onTextChanged;

  const _SearchBar({
    required this.focusNode,
    required this.isFocused,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const WhiteSpace(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.background,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.secondary.withOpacity(0.2),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: TextField(
                    focusNode: focusNode,
                    onChanged: onTextChanged,
                    cursorColor: context.colorScheme.onBackground,
                    cursorWidth: 1,
                    style: context.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      suffixIconConstraints: const BoxConstraints(minHeight: 0),
                      suffixIcon: AnimatedSwitcher(
                        switchInCurve: accelerateEasing,
                        duration: Durations.medium2,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          if (child.key == const ValueKey(1)) {
                            // Scale transition for the first icon
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          } else {
                            // Slide, rotate, and scale transition for the second icon
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(-0.2, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: RotationTransition(
                                turns: animation,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
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
                                  borderRadius: BorderRadius.circular(12.r),
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
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    focusNode.unfocus();
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
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
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
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<SmartphoneBrand> filteredList;
  final Function(Product) onProductClicked;

  const _SearchResults({
    required this.filteredList,
    required this.onProductClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 105,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(top: 10.h),
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
        height: 0.3.sh,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
                children: filteredList
                    .expand(
                      (brand) => brand.products.map(
                        (product) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => onProductClicked(Product(
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
        const Divider(thickness: 0, height: 0),
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
              const WhiteSpace(width: 10),
              Text(
                description,
                style: context.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
