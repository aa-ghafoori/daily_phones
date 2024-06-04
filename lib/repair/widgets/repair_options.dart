import 'package:daily_phones/core/common/widgets/rectangular_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/repair/bloc/repair_bloc.dart';
import 'package:daily_phones/repair/widgets/repair_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepairOptions extends StatefulWidget {
  const RepairOptions({super.key});

  @override
  State<RepairOptions> createState() => _RepairOptionsState();
}

class _RepairOptionsState extends State<RepairOptions> {
  bool _showAllRepairs = false;

  @override
  Widget build(BuildContext context) {
    final repairs = context.select((RepairBloc bloc) => bloc.state.repairs);
    final displayedRepairs = _showAllRepairs ? repairs : repairs.take(6);

    return Column(
      children: [
        ...displayedRepairs.map((repair) => RepairOption(repair: repair)),
        const WhiteSpace(height: 30),
        if (!_showAllRepairs)
          ShowAllRepairsButton(
              repairCount: repairs.length,
              onPressed: () => setState(() => _showAllRepairs = true)),
      ],
    );
  }
}

class ShowAllRepairsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int repairCount;

  const ShowAllRepairsButton({
    required this.onPressed,
    required this.repairCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.background,
      fontWeight: FontWeight.w300,
    );

    return RectangularButton(
      onPressed: onPressed,
      backgroundColor: context.colorScheme.secondary,
      text: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            style: textStyle,
            TextSpan(
              text: 'show all ',
              children: [
                TextSpan(
                    text: '$repairCount',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const TextSpan(text: ' repairs '),
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
}
