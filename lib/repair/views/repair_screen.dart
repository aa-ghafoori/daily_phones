import 'package:daily_phones/core/common/widgets/custom_scaffold.dart';
import 'package:daily_phones/repair/views/widgets/search_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepairScreen extends ConsumerWidget {
  const RepairScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CustomScaffold(body: [SearchDevice()]);
  }
}


// onTap: () =>
//             ref.read(searchBarNotifierProvider.notifier).handleTapOutside(),