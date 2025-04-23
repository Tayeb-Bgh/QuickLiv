import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
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
        color: kSecondaryWhite,
        border: Border.all(color: kLightGray, width: 1.0),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
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
              color: kPrimaryBlack,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            minFontSize: 1,
          ),

          SizedBox(height: 10),

          if (allCouponsPurchased)
            Center(
              child: AutoSizeText(
                'Vous avez consommé tous vos coupons',

                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                minFontSize: 1,
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
  ) {
    return Stack(
      children: [
        SvgPicture.asset(assetPath, fit: BoxFit.contain, height: height),

        if (currentPoint >= requiredPoint)
          FrostedCoupon(
            pointsText: requiredPoint,
            onPressed: () async {
              final notifier = ref.read(couponProvider.notifier);
              // Générer un code de réduction aléatoire
              final reductionCode = generateRandomCode(predefinedCodes);
              await notifier.createCoupon(reductionCode, discountRate);

              final status = ref.read(couponProvider).status;

              if (status == CouponStatus.error && context.mounted) {
                final error =
                    ref.read(couponProvider).errorMessage ??
                    "Une erreur inconnue.";
                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: Text('Erreur'),
                        content: Text(error),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                );
              } else if (status == CouponStatus.success && context.mounted) {
                final pointNotifier = ref.read(pointProvider.notifier);
                pointNotifier.subtractPoints(requiredPoint);
              }
            },
            isLargeCoupon: isLarge,
          ),
      ],
    );
  }
}
// import 'dart:ui';

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
// import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/dialogueWidget.dart';

// class Availablecoupon extends ConsumerWidget {
//   const Availablecoupon({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final pointsState = ref.watch(pointProvider);
//     final couponState = ref.watch(couponProvider);
//     final createdCoupons = couponState.coupons;
//     final size = MediaQuery.of(context).size;

//     // Observer les changements d'état pour les dialogues
//     ref.listen(couponProvider, (previous, current) {
//       // Fermer un dialogue de chargement existant
//       if (previous?.status == CouponStatus.loading && current.status != CouponStatus.loading) {
//         Navigator.of(context).pop();
//       }

//       // Afficher les messages d'erreur
//       if (current.status == CouponStatus.error && current.errorMessage != null) {
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (_) => ErrorDialog(
//             message: current.errorMessage!,
//             onDismiss: () {
//               ref.read(couponProvider.notifier).resetStatus();
//               Navigator.of(context).pop();
//             },
//           ),
//         );
//       }

//       // Afficher un message de succès
//       if (previous?.status != CouponStatus.success && current.status == CouponStatus.success) {
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (_) => SuccessDialog(
//             message: 'Coupon acheté avec succès!',
//             onDismiss: () {
//               ref.read(couponProvider.notifier).resetStatus();
//               Navigator.of(context).pop();
//             },
//           ),
//         );
//       }
//     });

//     final bool coupon30Purchased = _isCouponPurchased(createdCoupons, 30);
//     final bool coupon60Purchased = _isCouponPurchased(createdCoupons, 60);
//     final bool coupon100Purchased = _isCouponPurchased(createdCoupons, 100);

//     final bool allCouponsPurchased = 
//         coupon30Purchased && coupon60Purchased && coupon100Purchased;

//     final screenWidth = size.width;

//     // Si les points sont en cours de chargement
//     if (pointsState is AsyncLoading) {
//       return _buildLoadingContainer(screenWidth);
//     }

//     // Si une erreur s'est produite lors du chargement des points
//     if (pointsState is AsyncError) {
//       return _buildErrorContainer(screenWidth, (pointsState as AsyncError).error.toString());
//     }

//     // Points disponibles
//     final int currentPoints = pointsState.value ?? 0;

//     return Container(
//       width: screenWidth * 0.92,
//       height: 315,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: kSecondaryWhite,
//         border: Border.all(color: kLightGray, width: 1.0),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const AutoSizeText(
//             'Acheter des coupons',
//             style: TextStyle(
//               color: kPrimaryBlack,
//               fontSize: 20,
//               fontWeight: FontWeight.w800,
//             ),
//             maxLines: 1,
//             minFontSize: 1,
//           ),
//           const SizedBox(height: 10),
//           if (allCouponsPurchased)
//             const Center(
//               child: AutoSizeText(
//                 'Vous avez consommé tous vos coupons',
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 maxLines: 1,
//                 minFontSize: 1,
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
//                       child: !coupon30Purchased
//                           ? _buildCouponCard(
//                               context,
//                               'assets/images/coupon_30.svg',
//                               currentPoints,
//                               kRequiredPoints30,
//                               size.height * 0.10,
//                               ref,
//                               false,
//                               priceCoupon30,
//                               30,
//                             )
//                           : const SizedBox(), // Conteneur vide de la même taille
//                     ),
//                     SizedBox(width: size.width * 0.03),
//                     // Place réservée pour le coupon 60
//                     Expanded(
//                       child: !coupon60Purchased
//                           ? _buildCouponCard(
//                               context,
//                               'assets/images/coupon_60.svg',
//                               currentPoints,
//                               kRequiredPoints60,
//                               size.height * 0.10,
//                               ref,
//                               false,
//                               priceCoupon60,
//                               60,
//                             )
//                           : const SizedBox(),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: size.height * 0.016),
//                 // Grand coupon en bas
//                 Center(
//                   child: !coupon100Purchased
//                       ? _buildCouponCard(
//                           context,
//                           'assets/images/coupon_100.svg',
//                           currentPoints,
//                           kRequiredPoints100,
//                           size.height * 0.147,
//                           ref,
//                           true,
//                           priceCoupon100,
//                           100,
//                         )
//                       : const SizedBox(),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
  
//   // Container affiché pendant le chargement
//   Widget _buildLoadingContainer(double width) {
//     return Container(
//       width: width * 0.92,
//       height: 315,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: kSecondaryWhite,
//         border: Border.all(color: kLightGray, width: 1.0),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: const Center(
//         child: CircularProgressIndicator(color: kPrimaryRed),
//       ),
//     );
//   }

//   // Container affiché en cas d'erreur
//   Widget _buildErrorContainer(double width, String errorMessage) {
//     return Container(
//       width: width * 0.92,
//       height: 315,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: kSecondaryWhite,
//         border: Border.all(color: kLightGray, width: 1.0),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, color: kPrimaryRed, size: 40),
//             const SizedBox(height: 10),
//             Text(
//               'Erreur lors du chargement des points',
//               style: const TextStyle(
//                 color: kPrimaryRed,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 5),
//             Text(
//               errorMessage,
//               style: const TextStyle(color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
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
//               // Afficher un dialogue de chargement
//               showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (_) => const LoadingDialog(
//                   message: 'Achat du coupon en cours...',
//                 ),
//               );

//               final notifier = ref.read(couponProvider.notifier);
//               // Générer un code de réduction aléatoire
//               final reductionCode = generateRandomCode(predefinedCodes);
//               await notifier.createCoupon(reductionCode, discountRate);

//               final status = ref.read(couponProvider).status;

//               if (status == CouponStatus.success) {
//                 final pointNotifier = ref.read(pointProvider.notifier);
//                 await pointNotifier.subtractPoints(requiredPoint);
//               }
//             },
//             isLargeCoupon: isLarge,
//           ),
//         if (currentPoint < requiredPoint)
//           Positioned.fill(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//                 child: Container(
//                   color: Colors.black.withOpacity(0.3),
//                   child: Center(
//                     child: AutoSizeText(
//                       'Nécessite $requiredPoint points',
//                       style: const TextStyle(
//                         color: kPrimaryWhite,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                       maxLines: 1,
//                       minFontSize: 1,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }