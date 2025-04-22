import 'package:flutter/material.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/horizontal_radio_buttons.dart';

class _StickyRadioButtonsDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
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
