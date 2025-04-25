import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/widgets/horizontal_radio_buttons.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/widgets/restaurant_story_btn.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class RestaurantBottomSheet extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantBottomSheet({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.65,
      maxChildSize: 0.96,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: kSecondaryWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.19,
                  height: 5,
                  decoration: BoxDecoration(
                    color: kRegularGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: height * 0.013),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RestaurantStoryBtn(restaurant: restaurant),
                        SizedBox(width: width * 0.025),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      restaurant.name,
                                      style: TextStyle(
                                        fontSize: width * 0.05,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: width * 0.06,
                                        color: kPrimaryBlack,
                                      ),
                                      SizedBox(width: width * 0.019),
                                      Icon(
                                        Icons.facebook,
                                        size: width * 0.06,
                                        color: kPrimaryBlack,
                                      ),
                                      SizedBox(width: width * 0.019),
                                      Icon(
                                        Icons.share,
                                        size: width * 0.06,
                                        color: kPrimaryBlack,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.003),
                              AutoSizeText(
                                restaurant.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: kMediumGray),
                                minFontSize: 10,
                                maxFontSize: 15,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    size: 16,
                                    color: kPrimaryRed,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${restaurant.delivPrice.toStringAsFixed(2)} DA",
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(
                                    Icons.timer,
                                    size: 16,
                                    color: kPrimaryRed,
                                  ),
                                  const SizedBox(width: 4),
                                  Text("${parseTime(restaurant.delivTime)}"),
                                  const SizedBox(width: 12),
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: kPrimaryRed,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(restaurant.rating.toStringAsFixed(1)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.015),

                    // Filtres
                    /* SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          FilterChip(
                            label: Text("🍕 Pizza"),
                            selected: false,
                            onSelected: null,
                          ),
                          SizedBox(width: 8),
                          FilterChip(
                            label: Text("🌮 Tacos"),
                            selected: false,
                            onSelected: null,
                          ),
                          SizedBox(width: 8),
                          FilterChip(
                            label: Text("🍽 Plats"),
                            selected: false,
                            onSelected: null,
                          ),
                          SizedBox(width: 8),
                          FilterChip(
                            label: Text("🍟 Snacks"),
                            selected: false,
                            onSelected: null,
                          ),
                        ],
                      ),
                    ),
 */
                    HorizontalRadioButtons(restaurant.id),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
