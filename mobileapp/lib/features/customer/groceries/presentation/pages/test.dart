import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/business_story_btn.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/grocery_card.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/product_reduc_card.dart';
import '../providers/groceries_provider.dart';

class idkoui extends ConsumerStatefulWidget {
  const idkoui({super.key});

  @override
  ConsumerState<idkoui> createState() => _ExamplePageState();
}

class _ExamplePageState extends ConsumerState<idkoui> {
  @override
  Widget build(BuildContext context) {
  
    final bool isDarkMode = ref.watch(darkModeProvider);

    Color bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("test de mes widgets")),
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child:
            ),
          ),
        ],
      ),
    );
  }
}


/*  asyncGroceriesList.when(

          final asyncGroceriesList = ref.watch(groceriesListProvider);
            Future<void> _refresh() async {
              return await ref.refresh(groceriesListProvider);
            }

              data:
                  (groceries) => RefreshIndicator(
                    onRefresh: _refresh,
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: groceries.length,
                        itemBuilder: (context, index) {
                          final grocer = groceries[index];
                          return GroceryCard(grocery: grocer);
                        },
                      ),
                    ),
                  ),
              error: (err, _) => Text('errooor'),
              loading: () => const Center(child: CircularProgressIndicator()), */