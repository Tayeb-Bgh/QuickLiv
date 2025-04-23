// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart' show SvgPicture;
// import 'package:mobileapp/core/constants/constants.dart';
// import 'package:mobileapp/core/utils/utility_functions.dart';
// import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Coupon_provider.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Point_provider.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/Frosted_Coupon.dart';

// class Availablecoupon extends ConsumerWidget {
//   const Availablecoupon({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final pointsState = ref.watch(pointProvider);
//     final createdCoupons = ref.watch(
//       couponProvider.select((state) => state.coupons),
//     ); // Liste des coupons créés
//     final size = MediaQuery.of(context).size;

//     final bool coupon30Purchased = _isCouponPurchased(createdCoupons, 30);
//     final bool coupon60Purchased = _isCouponPurchased(createdCoupons, 60);
//     final bool coupon100Purchased = _isCouponPurchased(createdCoupons, 100);

//     final bool allCouponsPurchased =
//         coupon30Purchased && coupon60Purchased && coupon100Purchased;

//     final screenWidth = size.width;

//     return Container(
//       width: screenWidth * 0.92,
//       height: 315,
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: kSecondaryWhite,
//         border: Border.all(color: kLightGray, width: 1.0),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,

//         children: [
//           AutoSizeText(
//             'Acheter des coupons',
//             style: TextStyle(
//               color: kPrimaryBlack,
//               fontSize: 20,
//               fontWeight: FontWeight.w800,
//             ),
//             maxLines: 1,
//             minFontSize: 1,
//           ),

//           SizedBox(height: 10),

//           if (allCouponsPurchased)
//             Expanded(
//               child: Center(
//                 child: AutoSizeText(
//                   'Vous avez consommé tous vos coupons',

//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   maxLines: 1,
//                   minFontSize: 1,
//                 ),
//               ),
//             )
//           else
//             Column(
//               children: [
//                 // Les deux petits coupons en haut
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Place réservée pour le coupon 30
//                     Expanded(
//                       child:
//                           !coupon30Purchased
//                               ? _buildCouponCard(
//                                 context,
//                                 'assets/images/coupon_30.svg',
//                                 pointsState.value ?? 0,
//                                 kRequiredPoints30,
//                                 size.height * 0.10,
//                                 ref,
//                                 false,
//                                 priceCoupon30,
//                                 30,
//                               )
//                               : SizedBox(), // Conteneur vide de la même taille
//                     ),
//                     SizedBox(width: size.width * 0.03),
//                     // Place réservée pour le coupon 60
//                     Expanded(
//                       child:
//                           !coupon60Purchased
//                               ? _buildCouponCard(
//                                 context,
//                                 'assets/images/coupon_60.svg',
//                                 pointsState.value ?? 0,
//                                 kRequiredPoints60,
//                                 size.height * 0.10,
//                                 ref,
//                                 false,
//                                 priceCoupon60,
//                                 60,
//                               )
//                               : SizedBox(),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: size.height * 0.016),
//                 // Grand coupon en bas
//                 Center(
//                   child:
//                       !coupon100Purchased
//                           ? _buildCouponCard(
//                             context,
//                             'assets/images/coupon_100.svg',
//                             pointsState.value ?? 0,
//                             kRequiredPoints100,
//                             size.height * 0.147,
//                             ref,
//                             true,
//                             priceCoupon100,
//                             100,
//                           )
//                           : SizedBox(),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   static bool _isCouponPurchased(
//     List<CouponEntity> createdCoupons,
//     int discountRate,
//   ) {
//     return createdCoupons.any((coupon) => coupon.discountRate == discountRate);
//   }

//   static Widget _buildCouponCard(
//     BuildContext context,
//     String assetPath,
//     int currentPoint,
//     int requiredPoint,
//     double height,
//     WidgetRef ref,
//     bool isLarge,
//     double price,
//     int discountRate,
//   ) {
//     return Stack(
//       children: [
//         SvgPicture.asset(assetPath, fit: BoxFit.contain, height: height),

//         if (currentPoint >= requiredPoint)
//           FrostedCoupon(
//             pointsText: requiredPoint,
//             onPressed: () async {
//               try {
                
//                 final couponNotifier = ref.read(couponProvider.notifier);
//                 final reductionCode = generateRandomCode(predefinedCodes);
//                 await couponNotifier.createCoupon(reductionCode, discountRate);

                
//                 final pointNotifier = ref.read(pointProvider.notifier);
//                 await pointNotifier.subtractPoints(requiredPoint);
//                 await pointNotifier.refreshPoints();
//               } catch (e) {
//                 if (context.mounted) {
//                   Navigator.of(context).pop();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('erreur lors de l\'achat du coupon'),
//                     ),
//                   );
//                 }
//               }
//             },
//             isLargeCoupon: isLarge,
//           ),
//       ],
//     );
//   }
// }
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Coupon_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Point_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/Frosted_Coupon.dart';

class Availablecoupon extends ConsumerWidget {
  const Availablecoupon({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsState = ref.watch(pointProvider);
    final createdCoupons = ref.watch(
      couponProvider.select((state) => state.coupons),
    ); // Liste des coupons créés
    final size = MediaQuery.of(context).size;
    final isDarkMode = ref.watch(darkModeProvider);

    // Colors based on dark mode
    final backgroundColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final borderColor = isDarkMode ? kSecondaryDark : kLightGray;
    final textColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final shadowColor = isDarkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.25);
    final emptyTextColor = isDarkMode ? kLightGray : Colors.grey;

    final bool coupon30Purchased = _isCouponPurchased(createdCoupons, 30);
    final bool coupon60Purchased = _isCouponPurchased(createdCoupons, 60);
    final bool coupon100Purchased = _isCouponPurchased(createdCoupons, 100);

    final bool allCouponsPurchased =
        coupon30Purchased && coupon60Purchased && coupon100Purchased;

    final screenWidth = size.width;

    return Container(
      width: screenWidth * 0.92,
      height: 315,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          AutoSizeText(
            'Acheter des coupons',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            minFontSize: 1,
          ),

          SizedBox(height: 10),

          if (allCouponsPurchased)
            Expanded(
              child: Center(
                child: AutoSizeText(
                  'Vous avez consommé tous vos coupons',
                  style: TextStyle(
                    color: emptyTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  minFontSize: 1,
                ),
              ),
            )
          else
            Column(
              children: [
                // Les deux petits coupons en haut
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Place réservée pour le coupon 30
                    Expanded(
                      child:
                          !coupon30Purchased
                              ? _buildCouponCard(
                                context,
                                'assets/images/coupon_30.svg',
                                pointsState.value ?? 0,
                                kRequiredPoints30,
                                size.height * 0.10,
                                ref,
                                false,
                                priceCoupon30,
                                30,
                                isDarkMode,
                              )
                              : SizedBox(), // Conteneur vide de la même taille
                    ),
                    SizedBox(width: size.width * 0.03),
                    // Place réservée pour le coupon 60
                    Expanded(
                      child:
                          !coupon60Purchased
                              ? _buildCouponCard(
                                context,
                                'assets/images/coupon_60.svg',
                                pointsState.value ?? 0,
                                kRequiredPoints60,
                                size.height * 0.10,
                                ref,
                                false,
                                priceCoupon60,
                                60,
                                isDarkMode,
                              )
                              : SizedBox(),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.016),
                // Grand coupon en bas
                Center(
                  child:
                      !coupon100Purchased
                          ? _buildCouponCard(
                            context,
                            'assets/images/coupon_100.svg',
                            pointsState.value ?? 0,
                            kRequiredPoints100,
                            size.height * 0.147,
                            ref,
                            true,
                            priceCoupon100,
                            100,
                            isDarkMode,
                          )
                          : SizedBox(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  static bool _isCouponPurchased(
    List<CouponEntity> createdCoupons,
    int discountRate,
  ) {
    return createdCoupons.any((coupon) => coupon.discountRate == discountRate);
  }

  static Widget _buildCouponCard(
    BuildContext context,
    String assetPath,
    int currentPoint,
    int requiredPoint,
    double height,
    WidgetRef ref,
    bool isLarge,
    double price,
    int discountRate,
    bool isDarkMode,
  ) {
    return Stack(
      children: [
        SvgPicture.asset(assetPath, fit: BoxFit.contain, height: height),

        if (currentPoint >= requiredPoint)
          FrostedCoupon(
            pointsText: requiredPoint,
            onPressed: () async {
              try {
                
                final couponNotifier = ref.read(couponProvider.notifier);
                final reductionCode = generateRandomCode(predefinedCodes);
                await couponNotifier.createCoupon(reductionCode, discountRate);

                
                final pointNotifier = ref.read(pointProvider.notifier);
                await pointNotifier.subtractPoints(requiredPoint);
                await pointNotifier.refreshPoints();
              } catch (e) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('erreur lors de l\'achat du coupon'),
                    ),
                  );
                }
              }
            },
            isLargeCoupon: isLarge,
          ),
      ],
    );
  }
}