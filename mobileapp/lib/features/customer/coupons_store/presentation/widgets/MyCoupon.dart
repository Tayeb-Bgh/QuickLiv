// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mobileapp/core/constants/constants.dart';
// import 'package:mobileapp/core/utils/utility_functions.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/providers/add_coupon_provider.dart';

// class MyCoupon extends ConsumerWidget {
//   const MyCoupon({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final coupons = ref.watch(addCouponProvider);
//     final size = MediaQuery.of(context).size;
//     final screenWidth = size.width;
//     final screenHeight = size.height;

//     return Container(
//       width: screenWidth * 0.92,
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
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AutoSizeText(
//             'Mes Coupons',
//             style: TextStyle(
//               color: kPrimaryBlack,
//               fontSize: 20,
//               fontWeight: FontWeight.w800,
//             ),
//             maxLines: 1,
//             minFontSize: 1,
//           ),

//           Container(
//             height: screenHeight * 0.18,
//             child:
//                 coupons.isEmpty
//                     ? const Center(
//                       child: AutoSizeText(
//                         "Aucun coupon disponible pour le moment.",
//                         style: TextStyle(color: Colors.grey),
//                         maxLines: 1,
//                         minFontSize: 1,
//                       ),
//                     )
//                     : ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       padding: const EdgeInsets.symmetric(horizontal: 5),
//                       itemCount: coupons.length,
//                       itemBuilder: (context, index) {
//                         final coupon = coupons[index];

//                         final couponCode = generateRandomCode(predefinedCodes);

//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               height: screenHeight * 0.12,

//                               width: 187,
//                               child: SvgPicture.asset(
//                                 coupon.assetPath,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: screenWidth * 0.02,
//                                 vertical: screenHeight * 0.005,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: kPrimaryWhite,
//                                 border: Border.all(
//                                   color: kPrimaryBlack,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               child: Center(
//                                 child: AutoSizeText(
//                                   couponCode,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15,
//                                     color: kPrimaryBlack,
//                                   ),
//                                   minFontSize: 1,
//                                   maxLines: 1,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                       separatorBuilder:
//                           (context, index) => const SizedBox(width: 20),
//                     ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Coupon_provider.dart';

class MyCoupon extends ConsumerWidget {
  const MyCoupon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coupons = ref.watch(couponProvider).coupons;
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.92,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kSecondaryWhite,
        border: Border.all(color: kLightGray, width: 1.0),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AutoSizeText(
            'Mes Coupons',
            style: TextStyle(
              color: kPrimaryBlack,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            minFontSize: 1,
          ),
          SizedBox(height: size.height * 0.01),
          SizedBox(
            height: size.height * 0.18,
            child:
                coupons.isEmpty
                    ? const Center(
                      child: AutoSizeText(
                        "Aucun coupon disponible pour le moment.",
                        style: TextStyle(color: Colors.grey),
                        maxLines: 1,
                        minFontSize: 1,
                      ),
                    )
                    : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: coupons.length,
                      itemBuilder: (context, index) {
                        final coupon = coupons[index];
                        final discount = coupon.discountRate;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.12,
                              width: size.width * 0.45,
                              child: Builder(
                                builder: (context) {
                                  if (discount == 30) {
                                    return SvgPicture.asset(
                                      'assets/images/Coupon_30.svg',
                                      fit: BoxFit.contain,
                                    );
                                  } else if (discount == 60) {
                                    return SvgPicture.asset(
                                      'assets/images/Coupon_60.svg',
                                      fit: BoxFit.contain,
                                    );
                                  } else if (discount == 100) {
                                    return SvgPicture.asset(
                                      'assets/images/Coupon_100.svg',
                                      fit: BoxFit.contain,
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.005,
                              ),
                              decoration: BoxDecoration(
                                color: kPrimaryWhite,
                                border: Border.all(
                                  color: kPrimaryBlack,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),

                              child: Center(
                                child: AutoSizeText(
                                  coupon.reductionCode ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: kPrimaryBlack,
                                  ),
                                  minFontSize: 1,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder:
                          (context, index) =>
                              SizedBox(width: size.width * 0.05),
                    ),
          ),
        ],
      ),
    );
  }
}
