import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class OverviewCart extends StatefulWidget {
  const OverviewCart({
    super.key,
    required this.ref,
    required this.imgUrl,
    required this.name,
    required this.delPrice,
    required this.totalPrice,
    required this.prodPrice,
  });
  final dynamic ref;
  final String imgUrl;
  final String name;
  final String delPrice;
  final String totalPrice;
  final String prodPrice;
  @override
  State<OverviewCart> createState() => _OverviewCartState();
}

class _OverviewCartState extends State<OverviewCart> {
  late final dynamic ref;

  @override
  void initState() {
    super.initState();
    ref = widget.ref;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    final cardColor = isDarkMode ? kSecondaryDark : kLightGrayWhite;
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: width * 0.1,
              backgroundImage: NetworkImage(widget.imgUrl),
            ),
            Text(
              widget.name,
              style: TextStyle(
                color: kPrimaryRed,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              height: height * 0.13,
              width: width * 0.5,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _createTextRow(
                    'Prix des produits :',
                    widget.prodPrice,
                    false,
                    width,
                    height,
                    fontColor,
                  ),
                  _createTextRow(
                    'Frais de livraison :',
                    widget.delPrice,
                    false,
                    width,
                    height,
                    fontColor,
                  ),
                  _createTextRow(
                    'Prix total :',
                    widget.totalPrice,
                    true,
                    width,
                    height,
                    fontColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createTextRow(
    String text,
    String price,
    bool isTotal,
    double width,
    double height,
    Color fontColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          text,
          style: TextStyle(
            color: isTotal ? kPrimaryRed : fontColor,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w500,
          ),
        ),
        AutoSizeText(
          '$price DZD',
          style: TextStyle(
            color: isTotal ? kPrimaryRed : fontColor,
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
