import 'package:daily_phones/devices/bloc/devices_bloc.dart';
import 'package:daily_phones/devices/widgets/search_input_field.dart';
import 'package:daily_phones/devices/widgets/search_result_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';

class DeviceSearch extends StatefulWidget {
  const DeviceSearch({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  State<DeviceSearch> createState() => _DeviceSearchState();
}

class _DeviceSearchState extends State<DeviceSearch> {
  final GlobalKey _textFieldKey = GlobalKey();

  List<Product> products = [];

  void _scrollToTextField() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textFieldContext = _textFieldKey.currentContext;
      if (textFieldContext != null) {
        final box = textFieldContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero, ancestor: null);
        final topOffset = position.dy;

        widget.scrollController.animateTo(
          widget.scrollController.offset + topOffset - 160,
          duration: Durations.long4,
          curve: Curves.easeInOutExpo,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<DevicesBloc>();
    final state = bloc.state;
    final isFocused = state is DevicesFocused;
    if (isFocused) {
      _scrollToTextField();
      products = state.products;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            children: [
              SearchInputField(
                textFieldKey: _textFieldKey,
                focusNode: bloc.focusNode,
                isFocused: isFocused,
                handleTextChanged: (text) => bloc.add(DevicesTextChanged(text)),
              ),
              if (!isFocused) const _DeviceIcon(),
            ],
          ),
          SearchResultDropdownMenu(isFocused: isFocused, products: products),
        ],
      ),
    );
  }
}

class _DeviceIcon extends StatelessWidget {
  const _DeviceIcon();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        SvgPicture.asset(
          ImageRes.phone,
          height: 48.h,
          colorFilter: ColorFilter.mode(
              context.colorScheme.secondary.withOpacity(0.7), BlendMode.srcIn),
        ),
        SvgPicture.asset(
          ImageRes.question,
          height: 17,
          colorFilter:
              ColorFilter.mode(context.colorScheme.secondary, BlendMode.srcIn),
        ),
      ],
    );
  }
}
