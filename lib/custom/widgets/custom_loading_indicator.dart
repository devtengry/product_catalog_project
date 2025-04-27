import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';

class CustomLoadingIndicator extends ConsumerWidget {
  const CustomLoadingIndicator({
    this.leftIndicatorColor,
    this.rightIndicatorColor,
    super.key,
  });
  final Color? leftIndicatorColor;
  final Color? rightIndicatorColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: leftIndicatorColor ?? kOrangeLoading,
        rightDotColor: rightIndicatorColor ?? kPurpleLoading,
        size: 15.dg,
      ),
    );
  }
}
