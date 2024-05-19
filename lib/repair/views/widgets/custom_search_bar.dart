import 'package:daily_phones/repair/app/search_bar_provider.dart';
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
  late List<Map<String, String>> _filteredList;

  static const List<Map<String, String>> _smartphoneBrands = [
    {'brand': 'Apple', 'product': 'iPhone 14'},
    {'brand': 'Samsung', 'product': 'Galaxy S23'},
    {'brand': 'Google', 'product': 'Pixel 7'},
    {'brand': 'OnePlus', 'product': 'OnePlus 11'},
    {'brand': 'Sony', 'product': 'Xperia 1 IV'},
    {'brand': 'Xiaomi', 'product': 'Mi 12'},
    {'brand': 'Oppo', 'product': 'Find X5'},
    {'brand': 'Huawei', 'product': 'P50 Pro'},
    {'brand': 'LG', 'product': 'V60 ThinQ'},
    {'brand': 'Nokia', 'product': 'G50'},
    {'brand': 'Motorola', 'product': 'Moto G8'},
    {'brand': 'Lenovo', 'product': 'Lenovo Z6'},
    {'brand': 'ASUS', 'product': 'ZenFone 8'},
    {'brand': 'Realme', 'product': 'Realme X9'},
    {'brand': 'BlackBerry', 'product': 'BlackBerry Key3'},
    {'brand': 'CAT', 'product': 'CAT S62 Pro'},
    {'brand': 'Alcatel', 'product': 'Alcatel 3L'},
    {'brand': 'Honor', 'product': 'Honor 50'},
  ];

  @override
  void initState() {
    super.initState();
    _filteredList = _smartphoneBrands;
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
      _filteredList = _smartphoneBrands
          .where((element) =>
              element['brand']!.toLowerCase().contains(value.toLowerCase()) ||
              element['product']!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Column _buildDropDownMenuItem(
      BuildContext context, String brandName, String description) {
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
                    color: context.colorScheme.secondary, fontSize: 12),
              ),
              const WhiteSpace(width: 10),
              Text(
                description,
                style: context.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = ref.watch(searchBarNotifierProvider);

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
              Text.rich(TextSpan(
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w300),
                  text: ' Voer het ',
                  children: [
                    TextSpan(
                      text: 'merk, model',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: ' of '),
                    TextSpan(
                      text: 'modelcode',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: ' in.')
                  ]))
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
                      ]),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        TextField(
                          focusNode: _focusNode,
                          onChanged: _handleTextChanged,
                          cursorColor: context.colorScheme.onBackground,
                          cursorWidth: 1,
                          style: context.textTheme.bodyMedium,
                          decoration: InputDecoration(
                            suffixIconConstraints:
                                const BoxConstraints(minHeight: 0),
                            suffixIcon: !isFocused
                                ? Container(
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(searchBarNotifierProvider
                                                .notifier)
                                            .handleTapOutside();
                                      },
                                      child: Icon(
                                        CupertinoIcons.xmark_circle_fill,
                                        size: 30,
                                        color: context.colorScheme.onBackground
                                            .withOpacity(0.45),
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
                        if (isFocused)
                          WhiteSpace(
                            height: 0.3.sh,
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: _filteredList
                                      .map((brand) => _buildDropDownMenuItem(
                                          context,
                                          brand['brand']!,
                                          brand['product']!))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                      ],
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
                          BlendMode.srcIn),
                    ),
                    SvgPicture.asset(
                      ImageRes.question,
                      height: 17,
                      colorFilter: ColorFilter.mode(
                          context.colorScheme.secondary, BlendMode.srcIn),
                    )
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
