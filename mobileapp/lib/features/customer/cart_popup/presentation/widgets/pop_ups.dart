import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

import 'package:mobileapp/features/customer/cart_popup/business/mappers/to_product_cart.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/providers/cart_provider.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/widgets/cart_limit_alert_widget.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/product_entity.dart'
    as restau;
import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart'
    as restau_op;

Future<void> showQuantitySelectorDialog(
  BuildContext context,
  ref, {
  Product? product,
  ProductWithReduc? productWithRed,
  restau.Product? restauProduct,
  restau_op.Product? restauOpProduct,
}) async {
  final TextEditingController quantityController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      bool isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          final width = MediaQuery.of(context).size.width;
          final bool isDarkMode = ref.watch(darkModeProvider);
          final backgroundColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;
          final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
          return AlertDialog(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: SizedBox(
              width: width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Sélectionner la quantité",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Quantité"),
                            const SizedBox(height: 8),
                            TextField(
                              style: TextStyle(color: fontColor),
                              controller: quantityController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: InputDecoration(
                                filled: true,

                                fillColor:
                                    isDarkMode
                                        ? kSecondaryDark
                                        : kSecondaryWhite,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                  const SizedBox(height: 24),
                  isLoading
                      ? const CircularProgressIndicator()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            iconSize: width * 0.1,
                            icon: Icon(
                              Icons.close,
                              color: isDarkMode ? kLightGray : kDarkGray,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Container(
                            color: backgroundColor,
                            child: IconButton(
                              iconSize: width * 0.1,
                              icon: Icon(
                                Icons.check_circle,
                                color: kPrimaryRed,
                              ),
                              onPressed:
                                  isLoading
                                      ? null
                                      : () async {
                                        final int? parsedQuantity =
                                            int.tryParse(
                                              quantityController.text.trim(),
                                            );

                                        if (parsedQuantity != null) {
                                          setState(() => isLoading = true);
                                          try {
                                            if (!await _addToCart(
                                              ref,
                                              parsedQuantity,
                                              product: product,
                                              productWithRed: productWithRed,
                                              restauOpProduct: restauOpProduct,
                                              restauProduct: restauProduct,
                                            )) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (context) =>
                                                        const CartLimitAlertWidget(),
                                              );
                                              isLoading = false;
                                              return;
                                            }
                                            log('u are synchronizing the add');
                                            await ref
                                                .read(cartsProvider.notifier)
                                                .reload();
                                            if (!context.mounted) return;
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Produit ajouté au panier.",
                                                ),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          } catch (e) {
                                            if (!context.mounted) return;
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Erreur: ${e.toString()}",
                                                ),
                                              ),
                                            );
                                          } finally {
                                            if (context.mounted) {
                                              setState(() => isLoading = false);
                                            }
                                          }
                                        } else {
                                          if (!context.mounted) return;
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Veuillez entrer une quantité valide.",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> showQuantityWithUnitSelectorDialog(
  BuildContext context,
  ref, {
  Product? product,
  ProductWithReduc? productWithRed,
  restau.Product? restauProduct,
  restau_op.Product? restauOpProduct,
}) async {
  final TextEditingController quantityController = TextEditingController();
  String selectedUnit = 'g';

  await showDialog(
    context: context,
    builder: (context) {
      bool isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          final width = MediaQuery.of(context).size.width;
          final bool isDarkMode = ref.watch(darkModeProvider);
          final backgroundColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;
          final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
          return AlertDialog(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: SizedBox(
              width: width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Sélectionner la quantité",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Quantité"),
                            const SizedBox(height: 8),
                            TextField(
                              style: TextStyle(color: fontColor),
                              controller: quantityController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    isDarkMode
                                        ? kSecondaryDark
                                        : kSecondaryWhite,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Unité"),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color:
                                  isDarkMode ? kSecondaryDark : kSecondaryWhite,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                            ),
                            child: DropdownButton<String>(
                              dropdownColor:
                                  isDarkMode ? kPrimaryDark : kPrimaryWhite,
                              value: selectedUnit,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: isDarkMode ? kLightGray : kDarkGray,
                                size: 28,
                              ),
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(12),
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? kLightGray : kDarkGray,
                                fontWeight: FontWeight.w500,
                              ),
                              items:
                                  ['g', 'kg'].map((String unit) {
                                    return DropdownMenuItem<String>(
                                      value: unit,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 4.0,
                                        ),
                                        child: Text(
                                          unit,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                isDarkMode
                                                    ? kLightGray
                                                    : kDarkGray,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedUnit = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  isLoading
                      ? const CircularProgressIndicator()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            iconSize: width * 0.1,
                            icon: Icon(
                              Icons.close,
                              color: isDarkMode ? kLightGray : kDarkGray,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Container(
                            color: backgroundColor,
                            child: IconButton(
                              iconSize: width * 0.1,
                              icon: Icon(
                                Icons.check_circle,
                                color: kPrimaryRed,
                              ),
                              onPressed:
                                  isLoading
                                      ? null
                                      : () async {
                                        final double? quantity =
                                            double.tryParse(
                                              quantityController.text.trim(),
                                            );

                                        if (quantity != null) {
                                          setState(() => isLoading = true);
                                          try {
                                            int parsedQuantity =
                                                selectedUnit == 'kg'
                                                    ? kiloToGram(quantity)
                                                    : quantity.round();
                                            if (!await _addToCart(
                                              ref,
                                              parsedQuantity,
                                              // PASS UNIT
                                              product: product,
                                              productWithRed: productWithRed,
                                              restauOpProduct: restauOpProduct,
                                              restauProduct: restauProduct,
                                            )) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (context) =>
                                                        const CartLimitAlertWidget(),
                                              );
                                              isLoading = false;
                                              return;
                                            }
                                            await ref
                                                .read(cartsProvider.notifier)
                                                .reload();
                                            if (!context.mounted) return;
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Produit ajouté au panier.",
                                                ),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          } catch (e) {
                                            if (!context.mounted) return;
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Erreur: ${e.toString()}",
                                                ),
                                              ),
                                            );
                                          } finally {
                                            if (context.mounted) {
                                              setState(() => isLoading = false);
                                            }
                                          }
                                        } else {
                                          if (!context.mounted) return;
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Veuillez entrer une quantité valide.",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

_addToCart(
  ref,
  parsedQuantity, {
  Product? product,
  ProductWithReduc? productWithRed,
  restau.Product? restauProduct,
  restau_op.Product? restauOpProduct,
}) async {
  final addToCart = ref.read(addToCartUseCaseProvider);

  if (product != null) {
    final productCart = ToProductCart.fromProductGro(product, parsedQuantity);
    bool isAdded = await addToCart.call(
      productCart,
      parsedQuantity,
      product.idBusns,
    );
    await ref.read(cartsProvider.notifier).reload();
    return isAdded;
  }

  if (productWithRed != null) {
    final productCart = ToProductCart.fromProductWithReduc(
      productWithRed,
      parsedQuantity,
    );
    bool isAdded = await addToCart.call(
      productCart,
      parsedQuantity,
      productWithRed.idBusns,
    );
    await ref.read(cartsProvider.notifier).reload();
    return isAdded;
  }

  if (restauProduct != null) {
    final productCart = ToProductCart.fromProductRest(
      product: restauProduct,
      quantity: parsedQuantity,
    );
    bool isAdded = await addToCart.call(
      productCart,
      parsedQuantity,
      restauProduct.idBusns,
    );
    await ref.read(cartsProvider.notifier).reload();
    return isAdded;
  }

  if (restauOpProduct != null) {
    final productCart = ToProductCart.fromProductOpRest(
      product: restauOpProduct,
      quantity: parsedQuantity,
    );
    bool isAdded = await addToCart.call(
      productCart,
      parsedQuantity,
      restauOpProduct.idBusns,
    );
    await ref.read(cartsProvider.notifier).reload();
    return isAdded;
  }
}

int kiloToGram(double kg) {
  return (kg * 1000).round();
}
