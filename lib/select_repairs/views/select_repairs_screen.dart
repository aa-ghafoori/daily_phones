import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_phones/core/common/widgets/color_card.dart';
import 'package:daily_phones/core/common/widgets/custom_scaffold.dart';
import 'package:daily_phones/core/common/widgets/description.dart';
import 'package:daily_phones/core/common/widgets/new_card.dart';
import 'package:daily_phones/core/common/widgets/rectangular_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/constants.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/repair/views/widgets/custom_stepper.dart';
import 'package:daily_phones/repair/views/widgets/info_bar.dart';
import 'package:daily_phones/select_repairs/app/cubit/list_key_cubit.dart';
import 'package:daily_phones/select_repairs/app/cubit/product_cubit.dart';
import 'package:daily_phones/select_repairs/views/widgets/repair_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectRepairsScreen extends StatefulWidget {
  const SelectRepairsScreen({super.key});

  @override
  State<SelectRepairsScreen> createState() => _SelectRepairsScreenState();
}

class _SelectRepairsScreenState extends State<SelectRepairsScreen> {
  final CarouselController _controller = CarouselController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _repairSummaryKey = GlobalKey();
  bool _showAll = false;
  int _current = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToRepairSummary() {
    final context = _repairSummaryKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: Durations.long4, curve: Curves.easeInOutExpo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      controller: _scrollController,
      body: [
        OverflowBox(
          fit: OverflowBoxFit.deferToChild,
          maxWidth: 1.sw,
          child: Container(
            color: context.colorScheme.background,
            margin: EdgeInsets.only(top: 40.h),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: BlocBuilder<ProductCubit, ProductState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                redPrint('selectrepairpage: rendered.............');
                return Column(
                  children: [
                    const WhiteSpace(height: 40),
                    const CustomStepper(activeStep: 1),
                    InfoBar(
                      title: _productDetails(
                        image: ImageRes.iphone15,
                        title: '${state.product.brand}  ${state.product.name}',
                        description: 'Smartphone',
                      ),
                    ),
                    const WhiteSpace(height: 40),
                    const Description(text1: 'Selecteer', text2: 'kleur'),
                    const WhiteSpace(height: 20),
                    _buildColorGridView(state.product.colors, context, state),
                    const WhiteSpace(height: 40),
                    const Description(text1: 'Selecteer', text2: 'reparatie'),
                    _buildRepairOptions(state),
                    const WhiteSpace(height: 30),
                    if (!_showAll) _buildShowAllButton(context),
                    const WhiteSpace(height: 40),
                    _buildRecommendedAccessoriesSection(state),
                    const WhiteSpace(height: 80),
                    RepairSummary(
                      listKey: context.watch<ListKeyCubit>().state,
                      key: _repairSummaryKey,
                      selectedItems: state.selectedItems,
                      title: '${state.product.brand} ${state.product.name}',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorGridView(
      List<SmartphoneColor> colors, BuildContext context, ProductState state) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.7,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      children: colors
          .map((item) =>
              _productColor(context: context, item: item, state: state))
          .toList(),
    );
  }

  Widget _buildRepairOptions(ProductState state) {
    return Column(
      children: repairsList
          .take(_showAll ? repairsList.length : 6)
          .map((item) =>
              _repairOption(item, state.selectedItems.contains(item), state))
          .toList(),
    );
  }

  Widget _buildShowAllButton(BuildContext context) {
    return RectangularButton(
      onPressed: () => setState(() => _showAll = true),
      backgroundColor: context.colorScheme.secondary,
      text: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.background,
                fontWeight: FontWeight.w300),
            const TextSpan(
              text: 'show all ',
              children: [
                TextSpan(
                    text: '34', style: TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(text: ' repairs '),
              ],
            ),
          ),
          Icon(
            Icons.arrow_downward_sharp,
            size: 20,
            color: context.colorScheme.background,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedAccessoriesSection(ProductState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Description(text1: 'Recommended accessories'),
            Row(
              children: [
                GestureDetector(
                  onTap:
                      _current != 0 ? () => _controller.previousPage() : null,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      color: _current != 0
                          ? context.colorScheme.secondary
                          : context.colorScheme.primary,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 13.h,
                      color: context.colorScheme.background,
                    ),
                  ),
                ),
                const WhiteSpace(width: 5),
                GestureDetector(
                  onTap: _current != 3 ? () => _controller.nextPage() : null,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      color: _current != 3
                          ? context.colorScheme.secondary
                          : context.colorScheme.primary,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 13.h,
                      color: context.colorScheme.background,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        CarouselSlider(
          carouselController: _controller,
          items: accessoriesList
              .map((item) => _accessoryItem(
                  item, state.selectedItems.contains(item), state))
              .toList(),
          options: CarouselOptions(
            initialPage: _current,
            onPageChanged: (index, reason) => setState(() => _current = index),
            padEnds: false,
            height: 0.4.sh,
            viewportFraction: 0.75,
            enableInfiniteScroll: false,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget _productDetails({
    required String image,
    required String title,
    required String description,
  }) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            scale: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
                  style: context.textTheme.labelLarge
                      ?.copyWith(color: context.colorScheme.secondary),
                ),
              ],
            ),
          ),
        ],
      );

  ColorCard _productColor({
    required BuildContext context,
    required SmartphoneColor item,
    required ProductState state,
  }) {
    return ColorCard(
      state: state,
      item: item,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: item.color.withOpacity(0.8),
              ),
            ),
            const WhiteSpace(width: 8),
            Text(
              item.name.toUpperCase(),
              style: context.textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _repairOption(Repair repair, bool isSelected, ProductState state) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: NewCard(
          state: state,
          item: repair,
          onTap: _scrollToRepairSummary,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(repair.image, scale: 10),
                        const WhiteSpace(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                repair.title,
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${repair.duration} MINUTES',
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: context.colorScheme.secondary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp,
                                ),
                              )
                            ]),
                        const Spacer(),
                      ],
                    ),
                    const WhiteSpace(height: 15),
                    Text(
                      repair.description,
                      style: context.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: !isSelected
                      ? [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(7.r),
                                topLeft: Radius.circular(7.r),
                                topRight: Radius.circular(7.r),
                              ),
                              color: context.colorScheme.secondary,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            child: Text(
                              'starting at',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.background,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(7.r),
                                bottomRight: Radius.circular(7.r),
                              ),
                              color: context.colorScheme.primary,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '€',
                                  style: context.textTheme.labelLarge?.copyWith(
                                      color: context.colorScheme.secondary),
                                ),
                                Text(
                                  repair.price,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    color: context.colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]
                      : [
                          Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.r)),
                              color: context.colorScheme.secondary,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '€',
                                  style: context.textTheme.labelLarge?.copyWith(
                                      color: context.colorScheme.background),
                                ),
                                Text(
                                  repair.price,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    color: context.colorScheme.background,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _accessoryItem(
      Accessory accessory, bool isSelected, ProductState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      child: NewCard(
          state: state,
          item: accessory,
          onTap: _scrollToRepairSummary,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: context.colorScheme.secondary.withOpacity(0.5),
                      height: 0.2.sh,
                      child: ClipRect(
                        child: Image.asset(
                          accessory.image,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const WhiteSpace(height: 10),
                    Row(
                      children: [
                        Text(
                          accessory.title,
                          style: context.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const WhiteSpace(width: 5),
                        Icon(
                          CupertinoIcons.info_circle_fill,
                          size: 20.w,
                          color: context.colorScheme.onBackground
                              .withOpacity(0.35),
                        ),
                      ],
                    ),
                    const WhiteSpace(height: 8),
                    Text(
                      accessory.description,
                      style: context.textTheme.labelLarge,
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      color: isSelected
                          ? context.colorScheme.secondary
                          : context.colorScheme.primary,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '€',
                          style: context.textTheme.labelLarge?.copyWith(
                              color: isSelected
                                  ? context.colorScheme.background
                                  : context.colorScheme.secondary),
                        ),
                        Text(
                          accessory.price,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: isSelected
                                ? context.colorScheme.background
                                : context.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
