import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';
import 'package:product_catalog_project/ui/widgets/auth_widgets/auth_text_button.dart';

final rememberMeProvider = StateProvider<bool>((ref) => false);

class RememberMeCheckbox extends ConsumerWidget {
  const RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rememberMe = ref.watch(rememberMeProvider);

    return Expanded(
      child: CheckboxListTile(
        value: rememberMe,
        onChanged: (value) =>
            ref.read(rememberMeProvider.notifier).state = value!,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        title: Text(
          TextConstants.rememberMeText,
          style: TextStyles.textButton12Bold(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
