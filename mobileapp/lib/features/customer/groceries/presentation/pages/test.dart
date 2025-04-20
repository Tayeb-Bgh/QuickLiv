import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/groceries_list_view.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/groceries_stories.dart';
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
    final asyncGroceriesByCategoryList = ref.watch(
      groceriesByCategoryListProvider,
    );

    final asyncReductionsList = ref.watch(reductionsListProvider);

    final isDarkMode = ref.watch(darkModeProvider);
    final bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    return ListView(
      children: [
        ColoredBox(
          color: bgColor,
          child: Column(
            children: [
              GroceriesStoriesList(
                groceries: asyncGroceriesList,
                onRefresh: _refresh,
              ),
              GroceriesListView(
                groceries: asyncGroceriesList,
                onRefresh: _refresh,
              ),
              ReductionsListView(
                reductions: asyncReductionsList,
                onRefresh: _refresh,
              ),
              VerticalMarketList(
                groceries: asyncGroceriesByCategoryList,
                onRefresh: _refreshGroceriesByCategoy,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


/*   */