import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/product_details.dart';
import 'package:daily_phones/src/repair/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairScreen extends StatefulWidget {
  const RepairScreen({required this.product, super.key});

  static const routeName = '/repair';

  final Product product;

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
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
    final product = widget.product;

    return BlocListener<RepairBloc, RepairState>(
      listenWhen: (previous, current) =>
          previous.selectedItems.length < current.selectedItems.length,
      listener: (context, state) => _scrollToRepairSummary(),
      child: CustomScaffold(
        controller: _scrollController,
        body: Container(
          color: context.colorScheme.surface,
          margin: EdgeInsets.only(top: 30.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const WhiteSpace(height: 40),
              const CustomStepper(activeStep: 1),
              InfoBar(child: ProductDetails(product: product)),
              const WhiteSpace(height: 40),
              const Description(text1: 'Selecteer', text2: 'kleur'),
              const WhiteSpace(height: 20),
              ProductColorsGrid(product: product),
              const WhiteSpace(height: 40),
              const Description(text1: 'Selecteer', text2: 'reparatie'),
              const RepairOptions(),
              const WhiteSpace(height: 40),
              const RecommendedAccessories(),
              const WhiteSpace(height: 80),
              RepairSummary(key: _repairSummaryKey, product: product),
            ],
          ),
        ),
      ),
    );
  }
}
