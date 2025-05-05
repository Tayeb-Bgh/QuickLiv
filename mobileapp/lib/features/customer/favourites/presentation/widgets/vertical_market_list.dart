import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/favourites/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/favourites/presentation/widgets/business_card.dart';

class VerticalMarketList extends ConsumerWidget {
  final AsyncValue<List<Business>> businesses;
  final Function onRefresh;
  final bool isFull = true;

  const VerticalMarketList({
    super.key,
    required this.businesses,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final titleColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: businesses.when(
        data:
            (bsnss) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                 
                  height:
                      MediaQuery.of(context).size.height *
                      0.7, // ajuste selon besoin
                  child: ListView.builder(
                    itemCount: bsnss.length,
                    itemBuilder: (context, index) {
                      final grocer = bsnss[index];
                      return BusinessCard(
                        grocery: grocer,
                        onRemove:()async{   await onRefresh();},
                      );
                    },
                  ),
                ),
              ],
              
            ),
        error: (err, _) => const Text('Une erreur est survenue'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
    
  }
}  