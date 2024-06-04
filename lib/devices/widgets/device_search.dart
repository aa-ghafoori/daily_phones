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

class DeviceSearch extends StatelessWidget {
  DeviceSearch({required this.scrollController, super.key});

  final ScrollController scrollController;
  final GlobalKey _textFieldKey = GlobalKey();

  void _scrollToTextField() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textFieldContext = _textFieldKey.currentContext;
      if (textFieldContext != null) {
        final box = textFieldContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero, ancestor: null);
        final topOffset = position.dy;

        scrollController.animateTo(
          scrollController.offset + topOffset - 160,
          duration: Durations.long4,
          curve: Curves.easeInOutExpo,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DevicesBloc, DevicesState>(
      listenWhen: (previous, current) => current is DevicesFocused,
      buildWhen: (previous, current) =>
          current is DevicesFocused || current is DevicesUnfocused,
      listener: (context, state) => _scrollToTextField(),
      builder: (context, state) {
        final bloc = context.read<DevicesBloc>();
        final isFocused = state is DevicesFocused;
        final List<Product> products = isFocused ? (state).products : [];

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
                    handleTextChanged: (text) =>
                        bloc.add(DevicesTextChanged(text)),
                  ),
                  if (!isFocused) const DeviceIcon(),
                ],
              ),
              SearchResultDropdownMenu(
                  isFocused: isFocused, products: products),
            ],
          ),
        );
      },
    );
  }
}

class DeviceIcon extends StatelessWidget {
  const DeviceIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        SvgPicture.asset(
          ImageRes.phone,
          height: 48.h,
          colorFilter: ColorFilter.mode(
            context.colorScheme.secondary.withOpacity(0.7),
            BlendMode.srcIn,
          ),
        ),
        SvgPicture.asset(
          ImageRes.question,
          height: 17,
          colorFilter: ColorFilter.mode(
            context.colorScheme.secondary,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
