import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';

class CustomLoadingIndicator extends ConsumerWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: kOrangeLoading,
        rightDotColor: kPurpleLoading,
        size: 15.dg,
      ),
    );
  }
}
