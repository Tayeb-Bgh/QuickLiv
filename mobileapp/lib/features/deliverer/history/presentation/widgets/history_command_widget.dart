import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:mobileapp/features/customer/orders_history/presentation/widgets/order_Item.dart';
import 'package:mobileapp/features/customer/orders_history/presentation/widgets/rating_dialog.dart';

class HistoryCommandWidget extends StatefulWidget {
  final String imgUrl;
  final List<OrderItem> items;
  final String nameCom;
  final String statLivr;
  final String datLiv;
  final String nomLivreur;
  final String numTelephLivreur;
  final String price;

  const HistoryCommandWidget({
    super.key,
    required this.imgUrl,
    required this.items,
    required this.nameCom,
    required this.statLivr,
    required this.datLiv,
    required this.nomLivreur,
    required this.numTelephLivreur,
    required this.price,
  });

  @override
  State<HistoryCommandWidget> createState() => _HistoryCommandWidgetState();
}

class _HistoryCommandWidgetState extends State<HistoryCommandWidget> {
  bool _expanded = false;
  double _restaurantRating = 0;
  double _deliveryRating = 0;

  void _showRatingDialog(BuildContext context, bool isRestaurant) {
    String title =
        isRestaurant ? 'Noter ${widget.nameCom}' : 'Noter ${widget.nomLivreur}';
    double initialRating = isRestaurant ? _restaurantRating : _deliveryRating;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RatingDialog(
          title: title,
          initialRating: initialRating,
          onRatingConfirmed: (newRating) {
            setState(() {
              if (isRestaurant) {
                _restaurantRating = newRating;
              } else {
                _deliveryRating = newRating;
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialogWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: dialogWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 30, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Image.network(widget.imgUrl, fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              widget.nameCom,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 14,
                              maxLines: 1,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: IconButton(
                                    icon: Icon(
                                      _restaurantRating > 0
                                          ? Icons.star
                                          : Icons.star_border,
                                      color:
                                          _restaurantRating > 0
                                              ? const Color(0xFFF0F018)
                                              : const Color(0xFF8A8A8A),
                                    ),
                                    padding: EdgeInsets.zero,
                                    onPressed:
                                        () => _showRatingDialog(context, true),
                                  ),
                                ),
                                if (_restaurantRating > 0)
                                  AutoSizeText(
                                    '$_restaurantRating',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    minFontSize: 14,
                                    maxLines: 1,
                                  ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              widget.statLivr,
                              style: const TextStyle(
                                color: Color(0xFF009511),
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              minFontSize: 10,
                            ),
                            const SizedBox(width: 20),
                            AutoSizeText(
                              widget.datLiv,
                              style: const TextStyle(
                                color: Color(0xFF686868),
                                fontWeight: FontWeight.w700,
                              ),
                              minFontSize: 10,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 6, 30, 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    '../assets/images/Livreur.svg',
                    width: 18,
                    height: 17,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFE13838),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              widget.nomLivreur,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                              minFontSize: 12,
                              maxLines: 1,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      _deliveryRating > 0
                                          ? Icons.star
                                          : Icons.star_border,
                                      color:
                                          _deliveryRating > 0
                                              ? const Color(0xFFF0F018)
                                              : const Color(0xFF8A8A8A),
                                    ),
                                    onPressed:
                                        () => _showRatingDialog(context, false),
                                  ),
                                ),
                                if (_deliveryRating > 0)
                                  AutoSizeText(
                                    '$_deliveryRating',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    minFontSize: 14,
                                    maxLines: 1,
                                  ),
                              ],
                            ),
                          ],
                        ),
                        AutoSizeText(
                          widget.numTelephLivreur,
                          style: const TextStyle(color: Color(0xFF686868)),
                          minFontSize: 10,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 4, color: Colors.black12),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 8, 30, 1),
              child: Column(
                children: [
                  ...widget.items.take(2).map(_buildOrderItemRow),
                  if (_expanded)
                    ...widget.items.skip(2).map(_buildOrderItemRow),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    widget.price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE13838),
                    ),
                    minFontSize: 16,
                    maxLines: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    child: SvgPicture.asset(
                      _expanded
                          ? '../assets/images/Group_32.svg'
                          : '../assets/images/Group_32.svg',
                      width: 27,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFE13838),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemRow(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: AutoSizeText(
              'x${item.quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold),
              minFontSize: 12,
              maxLines: 1,
            ),
          ),
          Expanded(
            child: AutoSizeText(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              minFontSize: 12,
              maxLines: 1,
            ),
          ),
          AutoSizeText(
            '${item.price.toStringAsFixed(2)} DZD',
            style: const TextStyle(fontWeight: FontWeight.w400),
            textAlign: TextAlign.right,
            minFontSize: 12,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
