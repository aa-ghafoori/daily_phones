import 'package:daily_phones/core/common/widgets/new_card.dart';
import 'package:daily_phones/core/common/widgets/rectangular_button.dart';
import 'package:daily_phones/core/common/widgets/secondary_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/constants.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/select_repairs/app/cubit/list_key_cubit.dart';
import 'package:daily_phones/select_repairs/app/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RepairSummary extends StatelessWidget {
  const RepairSummary({
    required this.title,
    required this.selectedItems,
    required this.listKey,
    super.key,
  });

  final String title;
  final List selectedItems;
  final GlobalKey<AnimatedListState> listKey;

  @override
  Widget build(BuildContext context) {
    greenPrint('repairsummary: $listKey........');
    final items = selectedItems;

    final totalPrice = items.fold<double>(
        0, (total, item) => total + (double.parse(item.price)));

    String numberString = totalPrice.toStringAsFixed(2);
    List<String> parts = numberString.split('.');
    String decimalPart = parts.length > 1 ? parts[1] : '';

    return OverflowBox(
      fit: OverflowBoxFit.deferToChild,
      maxWidth: 1.sw,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.tertiary.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Repair List',
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const WhiteSpace(height: 10),
            Text(title.toUpperCase()),
            const WhiteSpace(height: 15),
            AnimatedList(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              key: listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) {
                return BuildCheckoutItem(
                  item: items[index],
                  animation: animation,
                  index: index,
                );
              },
            ),
            Divider(height: 50.h, thickness: 0),
            Row(
              children: [
                Text(
                  'Sub-total',
                  style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 15.sp,
                      color: context.colorScheme.onBackground.withOpacity(0.7)),
                ),
                const Spacer(),
                SizedBox(
                  width: 0.17.sw,
                  child: Center(
                    child: Text(
                      numberString,
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),
            const WhiteSpace(height: 15),
            Row(
              children: [
                SizedBox(
                  width: 0.5.sw,
                  child: NewCard(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Coupon Code',
                          hintStyle: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                            color: context.colorScheme.onBackground
                                .withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const WhiteSpace(width: 10),
                SecondaryButton(
                  backgroundColor:
                      context.colorScheme.secondary.withOpacity(0.15),
                  icon: Icon(
                    Icons.add,
                    size: 18,
                    color: context.colorScheme.secondary,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                ),
              ],
            ),
            Divider(height: 30.h, thickness: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: context.textTheme.titleMedium,
                    ),
                    Text(
                      'incl. tax (21%)',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: context.colorScheme.onBackground
                              .withOpacity(0.7)),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '€',
                      style: context.textTheme.bodyLarge,
                    ),
                    Text(
                      parts[0],
                      style: context.textTheme.headlineMedium,
                      strutStyle: const StrutStyle(
                          forceStrutHeight: true, height: 1.8, leading: 1.5),
                    ),
                    Text(
                      int.parse(decimalPart) > 0 ? decimalPart : '',
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 30.h, thickness: 0),
            RectangularButton(
              backgroundColor: context.colorScheme.secondary.withOpacity(0.15),
              text: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Send Offer PDF',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'Directly in your mailbox',
                      style: context.textTheme.labelMedium?.copyWith(
                          color:
                              context.colorScheme.secondary.withOpacity(0.9)),
                    ),
                  ],
                ),
              ),
            ),
            const WhiteSpace(height: 15),
            RectangularButton(
              backgroundColor: context.colorScheme.secondary,
              text: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Next Step',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.background,
                      ),
                    ),
                    Text(
                      'You only pay after your repair',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.background.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const WhiteSpace(height: 40),
          ],
        ),
      ),
    );
  }
}

// class BuildCheckoutItem extends StatelessWidget {
//   const BuildCheckoutItem(
//       {required this.index,
//       required this.item,
//       required this.animation,
//       super.key});

//   final dynamic item;
//   final Animation<double> animation;
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(-2, 0),
//         end: const Offset(0, 0),
//       ).animate(animation),
//       child: Row(
//         children: [
//           const WhiteSpace(height: 45),
//           GestureDetector(
//             behavior: HitTestBehavior.opaque,
//             onTap: () {
//               context.read<ProductCubit>().removeItem(item);
//               context.read<ListKeyCubit>().removeItem(index, item);
//             },
//             child: CircleAvatar(
//               backgroundColor: Colors.transparent,
//               child: SvgPicture.asset(
//                 ImageRes.close,
//                 height: 10.w,
//                 colorFilter: ColorFilter.mode(
//                   context.colorScheme.secondary.withOpacity(0.4),
//                   BlendMode.srcIn,
//                 ),
//               ),
//             ),
//           ),
//           const WhiteSpace(width: 30),
//           Text(
//             item.title,
//             style: context.textTheme.bodyMedium?.copyWith(
//               fontWeight: FontWeight.w300,
//             ),
//           ),
//           const Spacer(),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 5.h),
//             width: 0.17.sw,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4.r),
//               color: context.colorScheme.secondary,
//             ),
//             child: Center(
//               child: Text(
//                 item.price,
//                 style: context.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: context.colorScheme.background,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class BuildCheckoutItem extends StatelessWidget {
  const BuildCheckoutItem(
      {required this.index,
      required this.item,
      required this.animation,
      super.key});

  final dynamic item;
  final Animation<double> animation;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: Durations.extralong3, // adjust delay as needed
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-2, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: Row(
          children: [
            const WhiteSpace(height: 45),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.read<ProductCubit>().removeItem(item);
                context.read<ListKeyCubit>().removeItem(index, item);
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  ImageRes.close,
                  height: 10.w,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.secondary.withOpacity(0.4),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const WhiteSpace(width: 30),
            Text(
              item.title,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              width: 0.17.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: context.colorScheme.secondary,
              ),
              child: Center(
                child: Text(
                  item.price,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.background,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DelayedAnimation extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const DelayedAnimation({required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future.delayed(delay),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return child;
      },
    );
  }
}
