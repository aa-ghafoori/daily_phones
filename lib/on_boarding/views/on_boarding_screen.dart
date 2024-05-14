import 'package:daily_phones/core/common/widgets/round_button.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/core/common/widgets/custom_text.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/on_boarding/views/widgets/card_collection.dart';
import 'package:daily_phones/on_boarding/views/widgets/repairs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {},
          child: Image.asset(ImageRes.dpLogo, scale: 5.h),
        ),
        centerTitle: true,
        actions: [
          const RoundButton(text: 'Bel Ons'),
          const WhiteSpace(width: 20),
          Builder(
            builder: (context) => GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 15.h),
                child: const FaIcon(FontAwesomeIcons.user),
              ),
              onTap: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      endDrawer: const Drawer(),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.transparent,
        child: Center(
          child: Builder(
              builder: (context) => IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, right: 15),
                          child: FaIcon(FontAwesomeIcons.basketShopping),
                        ),
                        CircleAvatar(
                          foregroundColor: context.colorScheme.background,
                          backgroundColor: context.colorScheme.secondary,
                          radius: 11.h,
                          child: const CustomText(text: '1'),
                        ),
                      ],
                    ),
                  )),
        ),
      ),
      body: SafeArea(
        child: ColoredBox(
          color: context.colorScheme.onBackground.withOpacity(0.1),
          child: ListView(
            padding: EdgeInsets.all(12.h),
            children: const [
              CardCollection(),
              WhiteSpace(height: 30),
              Repairs(),
              WhiteSpace(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
