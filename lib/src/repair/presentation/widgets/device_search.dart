import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceSearch extends StatefulWidget {
  const DeviceSearch({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  State<DeviceSearch> createState() => _DeviceSearchState();
}

class _DeviceSearchState extends State<DeviceSearch> {
  final GlobalKey _textFieldKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  void _scrollToTextField() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final textFieldContext = _textFieldKey.currentContext;
        if (textFieldContext != null) {
          final box = textFieldContext.findRenderObject()! as RenderBox;
          final position = box.localToGlobal(Offset.zero);
          final topOffset = position.dy;

          widget.scrollController.animateTo(
            widget.scrollController.offset + topOffset - 160,
            duration: Durations.long4,
            curve: Curves.easeInOutExpo,
          );
        }
      },
    );
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
      if (_isFocused) {
        _scrollToTextField();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            children: [
              SearchInputField(
                textFieldKey: _textFieldKey,
                focusNode: _focusNode,
                isFocused: _isFocused,
                handleTextChanged: (text) => context
                    .read<RepairBloc>()
                    .add(RepairProductsFiltered(text)),
              ),
              if (!_isFocused) const _DeviceIcon(),
            ],
          ),
          BlocBuilder<RepairBloc, RepairState>(
            buildWhen: (previous, current) =>
                current is RepairProductsLoadSuccess ||
                current is RepairProductsFilterSuccess,
            builder: (context, state) {
              var products = <Product>[];
              if (state is RepairProductsLoadSuccess) {
                products = state.products;
              } else if (state is RepairProductsFilterSuccess) {
                products = state.products;
              }
              return SearchResultDropdownMenu(
                isFocused: _isFocused,
                products: products,
              );
            },
          ),
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
            context.colorScheme.secondary.withOpacity(0.7),
            BlendMode.srcIn,
          ),
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
