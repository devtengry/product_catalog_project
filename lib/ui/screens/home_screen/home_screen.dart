import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';
import 'package:product_catalog_project/ui/screens/home_screen/home_widgets/search_bar.dart'
    as custom;
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';
import 'package:product_catalog_project/ui/widgets/auth_widgets/auth_text_field.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final String _logoAssetPath = AssetsPath().logoAssetPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      appBar: MainAppBar(
        leadingIcon: IconButton(
          onPressed: () {},
          icon: Image.asset(_logoAssetPath),
        ),
        suffixText: 'Catalog',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                children: [
                  FilterChip(
                    backgroundColor: ProjectColors.cardBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide.none,
                    ),
                    label: Text('All'),
                    onSelected: (value) {},
                  ),
                ],
              ),
              SearchBar(),
              SizedBox(
                width: 350.w,
                height: 187.h,
                child: Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Best Seller',
                              style: TextStyles.bold20Header(context),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'View All',
                                style: TextStyles.textButton12SemiBold(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 210,
                          height: 140,
                          child: Card(
                            color: ProjectColors.cardBackground,
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 80,
                                    height: 120,
                                    child: Image.asset(
                                      'assets/images/dune_book.png',
                                    )),
                                Column(
                                  children: [
                                    Text('data'),
                                    Text('data'),
                                    Text('data'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
