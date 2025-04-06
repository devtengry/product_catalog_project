import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'package:product_catalog_project/ui/widgets/custom_loading_indicator.dart';

class ProductCoverImage extends ConsumerWidget {
  final String fileName;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ProductCoverImage({
    required this.fileName,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverUrl = ref.watch(coverImageProvider(fileName));

    return SizedBox(
      width: width,
      height: height,
      child: coverUrl.when(
        data: (url) => Image.network(
          url,
          fit: fit,
          errorBuilder: (_, __, ___) => const Icon(Icons.error),
        ),
        loading: () => const Center(child: CustomLoadingIndicator()),
        error: (_, __) => const Icon(Icons.file_download_off_outlined),
      ),
    );
  }
}

class ProductNameText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;

  final int maxLines;

  const ProductNameText({
    required this.title,
    this.fontSize = 12,
    this.maxLines = 2,
    this.fontWeight = FontWeight.w600,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(fontSize.sp, fontSize),
            fontWeight: fontWeight,
            color: ProjectColors.darkPurpleText,
          ),
    );
  }
}

class ProductAuthorText extends StatelessWidget {
  final String author;
  final double fontSize;
  final FontWeight fontWeight;

  const ProductAuthorText({
    required this.author,
    this.fontSize = 10,
    this.fontWeight = FontWeight.w700,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      author,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontSize: min(fontSize.sp, fontSize),
            fontWeight: fontWeight,
            color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
          ),
    );
  }
}

class ProductPriceText extends StatelessWidget {
  final String price;
  final double fontSize;
  final FontWeight fontWeight;

  const ProductPriceText({
    required this.price,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w700,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$price \$',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(fontSize.sp, fontSize),
            fontWeight: fontWeight,
            color: ProjectColors.priceText,
          ),
    );
  }
}
