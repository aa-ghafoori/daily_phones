import 'package:daily_phones/core/common/widgets/custom_scaffold.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/on_boarding/views/widgets/card_collection.dart';
import 'package:daily_phones/on_boarding/views/widgets/repairs.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late ScrollController _scrollController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 300 && !_isVisible) {
      setState(() {
        _isVisible = true;
      });
    } else if (_scrollController.offset <= 300 && _isVisible) {
      setState(() {
        _isVisible = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Durations.extralong4,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      controller: _scrollController,
      body: const [
        CardCollection(),
        WhiteSpace(height: 30),
        Repairs(),
      ],
    );
  }
}
          // if (_isVisible)
          //   Positioned(
          //     right: 10,
          //     bottom: 10,
          //     child: FloatingActionButton.small(
          //       onPressed: _scrollToTop,
          //       backgroundColor:
          //           context.colorScheme.background.withOpacity(0.9),
          //       shape: const CircleBorder(),
          //       splashColor: Colors.transparent,
          //       child: Icon(
          //         CupertinoIcons.chevron_up,
          //         size: 16,
          //         color: context.colorScheme.onBackground.withOpacity(0.7),
          //       ),
          //     ),
          //   )
