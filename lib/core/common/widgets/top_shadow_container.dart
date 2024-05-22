import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopShadowContainer extends StatelessWidget {
  final Widget child;

  const TopShadowContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: OverflowBox(
            fit: OverflowBoxFit.deferToChild,
            maxWidth: 1.sw,
            child: Container(
              height: 0.08,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(1),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: const Offset(0, -25),
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
