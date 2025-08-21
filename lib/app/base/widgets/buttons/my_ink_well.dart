import 'package:flutter/material.dart';
import 'package:newapps_task/app/base/constants/color_constants.dart';
import 'package:newapps_task/app/base/theme/theme_manager.dart';

class MyInkWell extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  final double borderRadius;

  const MyInkWell({
    required this.onTap,
    required this.child,
    this.borderRadius = Dimensions.radius_8dp,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: ColorConstants.transparent,
            child: InkWell(
              splashFactory: null,
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              splashColor: ColorConstants.canvasColor.withOpacity(0.3),
            ),
          ),
        ),
      ],
    );
  }
}
