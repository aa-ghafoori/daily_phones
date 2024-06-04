import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/core/res/predefined_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.background,
      margin: EdgeInsets.only(top: 50.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCenterContent(context),
          Divider(height: 80.h, thickness: 0),
          _buildLogoSection(context),
          Divider(height: 40.h, thickness: 0),
          _buildFooterBottom(context),
        ],
      ),
    );
  }

  Widget _buildCenterContent(BuildContext context) {
    return Center(
      child: WhiteSpace(
        width: 0.7.sw,
        child: Column(
          children: [
            _buildAddressItem(
                'Dokkum', 'Waagstraat 14A, 9101 LC Dokkum', context),
            const WhiteSpace(height: 30),
            _buildAddressItem(
                'Harlingen', 'Voorstraat 15, 8861 BC Harlingen', context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(ImageRes.dpLogo, scale: 3.7.sp),
        const WhiteSpace(height: 20),
        Text(
          'Professionele Apple telefoonreparatie in Dokkum of Harlingen door erkende Independent Repair Provider. Snelle, betrouwbare service met originele onderdelen.',
          style: context.textTheme.labelLarge?.copyWith(
            color: context.colorScheme.tertiary,
          ),
        ),
        const WhiteSpace(height: 20),
        _buildRichText('KVK', ' nummer: 86873350', context),
        const WhiteSpace(height: 5),
        _buildRichText('BTW', ' NR: NL864127728B01', context),
        const WhiteSpace(height: 30),
        _buildTextSection('Winkel', storeList, context),
        const WhiteSpace(height: 30),
        _buildTextSection('Daily Phones', dailyPhonesList, context),
        const WhiteSpace(height: 30),
        _buildFooterImages(),
        const WhiteSpace(height: 30),
        Text('Onze keurmerken', style: context.textTheme.bodyLarge),
        const WhiteSpace(height: 10),
        Image.asset(ImageRes.mark),
      ],
    );
  }

  Widget _buildFooterBottom(BuildContext context) {
    return Center(
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

  Widget _buildRichText(
      String boldText, String regularText, BuildContext context) {
    return Text.rich(
      TextSpan(
        text: boldText,
        style:
            context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
        children: [
          TextSpan(
            text: regularText,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSection(
      String title, List<String> items, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.bodyLarge),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.5),
            child: Text(
              item,
              style: context.textTheme.labelLarge
                  ?.copyWith(color: context.colorScheme.tertiary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterImages() {
    return Row(
      children: footerImages
          .map(
            (image) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(image, scale: 1.7),
            ),
          )
          .toList(),
    );
  }
}
