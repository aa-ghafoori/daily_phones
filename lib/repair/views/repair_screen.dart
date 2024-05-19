import 'package:daily_phones/core/common/widgets/custom_scaffold.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/repair/app/search_bar_provider.dart';
import 'package:daily_phones/repair/views/widgets/search_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepairScreen extends ConsumerWidget {
  const RepairScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      body: GestureDetector(
        onTap: () =>
            ref.read(searchBarNotifierProvider.notifier).handleTapOutside(),
        child: ColoredBox(
          color: context.colorScheme.onBackground.withOpacity(0.05),
          child: ListView(
            children: const [WhiteSpace(height: 40), SearchDevice()],
          ),
        ),
      ),
    );
  }
}
