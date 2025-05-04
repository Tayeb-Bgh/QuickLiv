import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/filters_checkboxes.dart';

class FixedTopBar extends ConsumerWidget {
  const FixedTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final appBarBgColor = kPrimaryRed;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final searchBarHeight = height * 0.04;
    final filterButtonsHeight = height * 0.16;
    final filtersBgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final Color searchBgColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    final Color searchTxtColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color searchHintTxtColor = isDarkMode ? kLightGray : kDarkGray;
    final search = ref.read(searchTextProvider);

    return SliverPersistentHeader(
      pinned: true,
      delegate: _FixedHeaderDelegate(
        height: filterButtonsHeight,
        child: Column(
          children: [
            // 🔴 SearchBar with red background
            Container(
              color: appBarBgColor,
              padding: EdgeInsets.only(
                top: height * 0.03,
                bottom: height * 0.01,
              ),
              child: Center(
                child: SizedBox(
                  width: width * 0.9,
                  height: searchBarHeight,
                  child: SearchBar(
                    controller: ref.watch(searchControllerProvider),
                    onChanged: (value) {
                      ref.read(searchTextProvider.notifier).state = value;
                    },
                    hintText: 'Rechercher un produit ...',
                    hintStyle: WidgetStateProperty.all(
                      TextStyle(color: searchHintTxtColor),
                    ),

                    leading: Icon(Icons.search, color: searchHintTxtColor),
                    backgroundColor: WidgetStateProperty.all(searchBgColor),
                    textStyle: WidgetStateProperty.all(
                      TextStyle(color: searchTxtColor),
                    ),
                    elevation: WidgetStateProperty.all(0),
                    shadowColor: WidgetStateProperty.all(Colors.transparent),
                    surfaceTintColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            // ⚪ Filter buttons with white background
            search == ""
                ? Container(
                  color: filtersBgColor,
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: FiltersCheckboxButtons(),
                )
                : Container(
                  padding: EdgeInsets.only(left: kDefaultPadding * width),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Résultats pour : \"$search\"",
                    style: TextStyle(
                      color: searchTxtColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _FixedHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_FixedHeaderDelegate oldDelegate) {
    return height != oldDelegate.height || child != oldDelegate.child;
  }
}
