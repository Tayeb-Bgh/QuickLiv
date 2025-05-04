import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/research/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/research/presentation/providers/research_provider.dart';
import 'package:mobileapp/features/customer/research/presentation/widgets/business_products_widget.dart';
import 'package:mobileapp/features/customer/research/presentation/widgets/business_type_radios_buttons.dart';
import 'package:mobileapp/features/customer/research/presentation/widgets/no_products_found.dart';
import 'package:mobileapp/features/customer/research/presentation/widgets/search_prompt_widget.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color appBarBgColor = kPrimaryRed;
    final Color bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final Color searchBgColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final Color searchTxtColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final Color hintTextColor = isDarkMode ? kLightGray : kMediumGray;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final topBarPadding = MediaQuery.of(context).padding.top;
    final topBarHeight = topBarPadding + height * 0.17;

    final asyncBusinesses = ref.watch(searchedBusinessesProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: topBarHeight - topBarPadding,
        backgroundColor: bgColor,
        flexibleSpace: Column(
          children: [
            Container(height: topBarPadding, color: appBarBgColor),
            Container(
              color: appBarBgColor,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      right: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: SearchBar(
                            controller: ref.watch(searchControllerProvider),
                            onChanged: (value) {
                              ref.read(searchTextProvider.notifier).state =
                                  value;
                            },
                            shadowColor: const WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                            autoFocus: true,
                            backgroundColor: WidgetStatePropertyAll(
                              searchBgColor,
                            ),
                            textStyle: WidgetStatePropertyAll(
                              TextStyle(color: searchTxtColor),
                            ),
                            hintText: "Rechercher ...",
                            hintStyle: WidgetStatePropertyAll(
                              TextStyle(color: hintTextColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BusinessTypeRadiosButtons(parentHeight: topBarHeight),
                ],
              ),
            ),
          ],
        ),
      ),
      body: asyncBusinesses.when(
        data: (businesses) {
          if (ref.watch(searchTextProvider).isEmpty) {
            return const SearchPrompt();
          }
          String? type =
              ref.watch(selectedTypeProvider) == "Restaurants"
                  ? "restaurant"
                  : ref.watch(selectedTypeProvider) == "Courses"
                  ? "grocery"
                  : null;

          List<Business> filteredBusinesses = ref
              .watch(filterBusinessesProvider)
              .call(businesses, type);

          if (filteredBusinesses.isEmpty) return const NoProductsFound();

          return Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.037),
            color: bgColor,
            child: ListView.builder(
              itemCount: filteredBusinesses.length,
              itemBuilder: (context, index) {
                final business = filteredBusinesses[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: BusinessProducts(business: business),
                );
              },
            ),
          );
        },
        error: (error, _) => const NoProductsFound(),
        loading:
            () => const Center(
              child: CircularProgressIndicator(color: kPrimaryRed),
            ),
      ),
    );
  }
}
