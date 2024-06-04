import 'package:daily_phones/core/common/widgets/custom_scaffold.dart';
import 'package:daily_phones/core/common/widgets/description.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/devices/widgets/custom_stepper.dart';
import 'package:daily_phones/core/common/widgets/info_bar.dart';
import 'package:daily_phones/repair/bloc/repair_bloc.dart';
import 'package:daily_phones/repair/widgets/recommended_accessories.dart';
import 'package:daily_phones/repair/widgets/product_colors_grid.dart';
import 'package:daily_phones/repair/widgets/repair_options.dart';
import 'package:daily_phones/repair/widgets/repair_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_devices_repository/mobile_devices_repository.dart';

class RepairsScreen extends StatefulWidget {
  const RepairsScreen({super.key});

  @override
  State<RepairsScreen> createState() => _RepairsScreenState();
}

class _RepairsScreenState extends State<RepairsScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _repairSummaryKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToRepairSummary() {
    final context = _repairSummaryKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Durations.extralong2,
        curve: Curves.easeInOutExpo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = context.select((RepairBloc bloc) => bloc.state.product);

    return BlocListener<RepairBloc, RepairState>(
      listenWhen: (previous, current) =>
          previous.selectedItems.length < current.selectedItems.length,
      listener: (context, state) => _scrollToRepairSummary(),
      child: CustomScaffold(
        controller: _scrollController,
        body: Container(
          color: context.colorScheme.background,
          margin: EdgeInsets.only(top: 30.h),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              const WhiteSpace(height: 40),
              const CustomStepper(activeStep: 1),
              product != null
                  ? InfoBar(title: ProductDetails(product: product))
                  : const Center(child: CircularProgressIndicator()),
              const WhiteSpace(height: 40),
              const Description(text1: 'Selecteer', text2: 'kleur'),
              const WhiteSpace(height: 20),
              const ProductColorsGrid(),
              const WhiteSpace(height: 40),
              const Description(text1: 'Selecteer', text2: 'reparatie'),
              const RepairOptions(),
              const WhiteSpace(height: 40),
              const RecommendedAccessories(),
              const WhiteSpace(height: 80),
              product != null
                  ? RepairSummary(key: _repairSummaryKey, product: product)
                  : const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(product.imageUrl, scale: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${product.brand} ${product.name}',
                style: context.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                Product.productTypeToString(product.type),
                style: context.textTheme.labelLarge
                    ?.copyWith(color: context.colorScheme.secondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
