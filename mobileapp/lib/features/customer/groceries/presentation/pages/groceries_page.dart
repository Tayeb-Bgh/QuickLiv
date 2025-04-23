import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/groceries_list_view.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/groceries_stories.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/horizontal_radio_buttons.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/reductions_list_view.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/vertical_market_list.dart';
import '../providers/groceries_provider.dart';

class GroceriesPageTest extends ConsumerStatefulWidget {
  
  const GroceriesPageTest({super.key});

  @override
  ConsumerState<GroceriesPageTest> createState() => _GroceriesPageTestState();
}

class _GroceriesPageTestState extends ConsumerState<GroceriesPageTest> {
  Future<void> _refresh() async {
    return await ref.refresh(groceriesListProvider);
  }

  Future<void> _refreshGroceriesByCategoy() async {
    ref.invalidate(groceriesByCategoryListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final asyncGroceriesList = ref.watch(groceriesListProvider);
    final asyncGroceriesByCategoryList = ref.watch(groceriesByCategoryListProvider);
    final asyncReductionsList = ref.watch(reductionsListProvider);

    final isDarkMode = ref.watch(darkModeProvider);
    final bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ColoredBox(
      color: bgColor,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GroceriesStoriesList(
              groceries: asyncGroceriesList,
              onRefresh: _refresh,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: height * 0)),

          // Sticky Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyRadioButtonsDelegate(isDarkMode: isDarkMode,height: height),
          ),

          SliverToBoxAdapter(child: SizedBox(height: height * 0)),

          SliverToBoxAdapter(
            child: ReductionsListView(
              reductions: asyncReductionsList,
              onRefresh: _refresh,
            ),
          ),
          SliverToBoxAdapter(
            child: GroceriesListView(
              groceries: asyncGroceriesList,
              onRefresh: _refresh,
            ),
          ),
          SliverToBoxAdapter(
            child: VerticalMarketList(
              groceries: asyncGroceriesByCategoryList,
              onRefresh: _refreshGroceriesByCategoy,
            ),
          ),
        ],
      ),
    );
  }
}


class _StickyRadioButtonsDelegate extends SliverPersistentHeaderDelegate {
  final bool isDarkMode;
  final double height;
  _StickyRadioButtonsDelegate({required this.isDarkMode,required this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    
    
    return ColoredBox(

      color:  isDarkMode?  kPrimaryDark : kSecondaryWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.015),
        child: HorizontalRadioButtons(),
      ),
    );
  }

  @override
  double get maxExtent => height * 0.0675;

  @override
  double get minExtent => height * 0.0675;

  @override
  bool shouldRebuild(_StickyRadioButtonsDelegate oldDelegate) => false;
}
