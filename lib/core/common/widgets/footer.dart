import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/constants.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxWidth: 1.sw,
      fit: OverflowBoxFit.deferToChild,
      child: Container(
        color: context.colorScheme.background,
        margin: EdgeInsets.only(top: 50.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: WhiteSpace(
                width: 0.7.sw,
                child: Column(
                  children: [
                    _buildAddressItem(
                        'Dokkum', 'Waagstraat 14A, 9101 LC Dokkum', context),
                    const WhiteSpace(height: 30),
                    _buildAddressItem('Harlingen',
                        'Voorstraat 15, 8861 BC Harlingen', context),
                  ],
                ),
              ),
            ),
            Divider(height: 80.h, thickness: 0),
            Image.asset(ImageRes.dpLogo, scale: 3.7.sp),
            const WhiteSpace(height: 20),
            Text(
              'Professionele Apple telefoonreparatie in Dokkum of Harlingen door erkende Independent Repair Provider. Snelle, betrouwbare service met originele onderdelen.',
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.tertiary,
              ),
            ),
            const WhiteSpace(height: 20),
            Text.rich(
              TextSpan(
                text: 'KVK',
                style: context.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
                children: const [
                  TextSpan(
                      text: ' nummer: 86873350',
                      style: TextStyle(fontWeight: FontWeight.w300))
                ],
              ),
            ),
            const WhiteSpace(height: 5),
            Text.rich(
              TextSpan(
                text: 'BTW',
                style: context.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
                children: const [
                  TextSpan(
                      text: ' NR: NL864127728B01',
                      style: TextStyle(fontWeight: FontWeight.w300))
                ],
              ),
            ),
            const WhiteSpace(height: 30),
            Text('Winkel', style: context.textTheme.bodyLarge),
            ...storeList.map(
              (e) => Column(
                children: [
                  const WhiteSpace(height: 13),
                  Text(
                    e,
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: context.colorScheme.tertiary),
                  ),
                ],
              ),
            ),
            const WhiteSpace(height: 30),
            Text('Daily Phones', style: context.textTheme.bodyLarge),
            ...dailyPhonesList.map(
              (e) => Column(
                children: [
                  const WhiteSpace(height: 13),
                  Text(
                    e,
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: context.colorScheme.tertiary),
                  ),
                ],
              ),
            ),
            const WhiteSpace(height: 30),
            Row(
              children: [
                ...footerImages.map(
                  (e) => Row(children: [
                    Image.asset(e, scale: 1.7),
                    const WhiteSpace(width: 10)
                  ]),
                ),
              ],
            ),
            const WhiteSpace(height: 30),
            Text(
              'Onze keurmerken',
              style: context.textTheme.bodyLarge,
            ),
            const WhiteSpace(height: 10),
            Image.asset(ImageRes.mark),
            Divider(height: 40.h, thickness: 0),
            Center(
              child: Column(
                children: [
                  Text(
                    '© Daily Phones 2024. All rights reserved.',
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: context.colorScheme.tertiary),
                  ),
                  Text(
                    'Made by Empireyo',
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: context.colorScheme.tertiary),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddressItem(String city, String address, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Phones | $city',
              style: context.textTheme.bodyLarge,
            ),
            const WhiteSpace(width: 15),
            Icon(
              CupertinoIcons.chevron_right_circle_fill,
              color: context.colorScheme.secondary,
            )
          ],
        ),
        const WhiteSpace(height: 5),
        Text(
          address,
          style: context.textTheme.bodySmall
              ?.copyWith(color: context.colorScheme.tertiary),
        ),
      ],
    );
  }
}
