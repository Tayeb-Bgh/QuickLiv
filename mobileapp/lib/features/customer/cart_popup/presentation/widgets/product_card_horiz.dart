import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/product_cart.dart';
import 'package:mobileapp/features/customer/cart_popup/data/services/cart_service.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/providers/cart_provider.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/widgets/change_weight_pop_up.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/widgets/notice_popup.dart';

class ProductCardHoriz extends ConsumerWidget {
  final int cartNumber;
  final ProductCart productCart;
  const ProductCardHoriz(this.productCart, this.cartNumber, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TextEditingController controller = TextEditingController();
    final backgroundColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final cardColor = isDarkMode ? kSecondaryDark : kLightGray;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      padding: const EdgeInsets.all(8),
      width: width * 0.9,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      height: height * 0.15,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              productCart.imgUrl,
              width: height * 0.12,
              height: height * 0.12,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => Container(
                    width: height * 0.12,
                    height: height * 0.12,
                    color: kLightGrayWhite,
                    child: const Icon(Icons.broken_image),
                  ),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productCart.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    ),

                    AutoSizeText(
                      productCart.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: fontColor),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${productCart.price.toStringAsFixed(2)} DZD',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    Expanded(child: const SizedBox()),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final String boxName = 'cartBox$cartNumber';
                            await CartService.deleteFromCard(
                              boxName,
                              productCart.id,
                            );
                            await ref.read(cartsProvider.notifier).reload();
                          },
                          child: _squareButton(Icons.delete, Colors.red),
                        ),
                        const SizedBox(width: 4),

                        if (productCart.unitProd == false) ...[
                          _inputField(
                            controller: controller,
                            value: productCart.quantity,
                            ref: ref,
                            color: cardColor,
                            fontColor: fontColor,
                            isDisable: false,
                          ),
                        ] else ...[
                          SizedBox(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    changeQuantitySelectorDialog(
                                      context,
                                      ref,
                                      productCart.quantity.toString(),
                                      cartNumber,
                                      productCart.id,
                                    );
                                  },
                                  child: _inputField(
                                    controller: controller,
                                    value: productCart.quantity,
                                    ref: ref,
                                    color: cardColor,
                                    fontColor: fontColor,
                                    isDisable: true,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                _labelButton(
                                  _getUnitForQuantity(productCart.quantity),
                                  cardColor,
                                  fontColor,
                                ),
                              ],
                            ),
                          ),
                        ],

                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return NoticeInputWidget(
                                  boxName: 'cartBox$cartNumber',
                                  idProd: productCart.id,
                                  notice: productCart.notice,
                                );
                              },
                            );
                          },
                          child: _squareButton(
                            Icons.receipt_long,
                            productCart.notice == ""
                                ? kPrimaryRed
                                : kSecondaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _squareButton(IconData icon, Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }

  Widget _labelButton(String text, Color cardColor, Color fontColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      height: 28,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(color: fontColor, fontSize: 13)),
    );
  }

  String _formatQuantity(int quantityInGrams) {
    if (quantityInGrams >= 1000) {
      final double kg = quantityInGrams / 1000;
      return kg.toStringAsFixed(2);
    } else {
      return quantityInGrams.toStringAsFixed(0);
    }
  }

  String _getUnitForQuantity(int quantityInGrams) {
    return quantityInGrams >= 1000 ? 'kg' : 'g';
  }

  Widget _inputField({
    required TextEditingController controller,
    required int value,
    required ref,
    required Color color,
    required Color fontColor,
    required bool isDisable,
  }) {
    controller.text = _formatQuantity(value);

    return SizedBox(
      width: 33,
      height: 30,
      child: TextField(
        enabled: !isDisable,
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        maxLength: 4,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
          LengthLimitingTextInputFormatter(4),
        ],

        style: TextStyle(fontSize: 12, color: fontColor),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: color,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.white54),
          isDense: false,
          contentPadding: EdgeInsets.all(3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (value) async {
          log(' the value is changed $value');
          await CartService.updateProduct(
            boxName: 'cartBox$cartNumber',
            productId: productCart.id.toString(),
            quantity: int.parse(value),
          );
          log(
            '||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||',
          );
          await ref.read(cartsProvider.notifier).reload();
        },
      ),
    );
  }
}
