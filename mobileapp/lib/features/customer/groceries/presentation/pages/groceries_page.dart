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
          SliverToBoxAdapter(child: SizedBox(height: 10)),

          // Sticky Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyRadioButtonsDelegate(isDarkMode: isDarkMode),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 13)),

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
  _StickyRadioButtonsDelegate({required this.isDarkMode});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    
    return ColoredBox(
      color:  isDarkMode?  kPrimaryDark : kSecondaryWhite,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: HorizontalRadioButtons(),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(_StickyRadioButtonsDelegate oldDelegate) => false;
}
