import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/customer/favourites/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/favourites/presentation/providers/favourites_provider.dart';
import 'package:mobileapp/features/customer/favourites/presentation/widgets/horizontal_radio_buttons.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/favourites/presentation/widgets/vertical_market_list.dart';

class FavouritesPageTest extends ConsumerStatefulWidget {
  const FavouritesPageTest({super.key});
  @override
  ConsumerState<FavouritesPageTest> createState() => _favouritesPageTestState();
}

class _favouritesPageTestState extends ConsumerState<FavouritesPageTest> {
  Future<void> _refresh() async {
    ref.invalidate(prov(ref.read(selectedTypeProvider)));
    return await ref.refresh(favouritesListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final selectedType = ref.watch(selectedTypeProvider);
    final asyncFavouritesList = ref.watch(prov(selectedType));
    final asyncFavouritesListByType = ref.watch(prov(selectedType));
    final isDarkMode = ref.watch(darkModeProvider);
    final bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final tc = isDarkMode ? kSecondaryWhite : kPrimaryDark;

    return ColoredBox(
      color: bgColor,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 10)),

          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyRadioButtonsDelegate(isDarkMode: isDarkMode),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 8)),
          //SliverToBoxAdapter(child: VerticalMarketList(businesses: asyncFavouritesList, onRefresh: _refresh,))
          asyncFavouritesList.when(
            data: (list) {
              if (list.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Text(
                        "Aucun favori trouvé",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: tc,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: VerticalMarketList(
                    businesses: AsyncValue.data(list),
                    onRefresh: _refresh,
                  ),
                );
              }
            },
            loading:
                () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
            error:
                (err, stack) => SliverFillRemaining(
                  child: Center(child: Text('Erreur : $err')),
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
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      height: maxExtent,
      child: ColoredBox(
        color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: HorizontalRadioButtons(),
        ),
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
