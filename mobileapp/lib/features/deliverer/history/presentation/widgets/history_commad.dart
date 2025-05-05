import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderItem2 {
  final String name;
  final int quantity;
  final int unite;

  OrderItem2({required this.unite, required this.name, required this.quantity});
}

class HistoryCommand extends ConsumerStatefulWidget {
  final int orderNumber;
  final String imgUrl;
  final List<OrderItem2> items;
  final String restaurantName;
  final String status;
  final String date;
  final String personName;
  final String locaComm;
  final String price;
  final String totalPrice;
  final int paymentMethod;
  final String heure;
  final String location;
  const HistoryCommand({
    super.key,
    required this.orderNumber,
    required this.imgUrl,
    required this.items,
    required this.restaurantName,
    required this.status,
    required this.date,
    required this.personName,
    required this.locaComm,
    required this.price,
    required this.totalPrice,
    required this.paymentMethod,
    required this.heure,
    required this.location,
  });
  @override
  ConsumerState<HistoryCommand> createState() => _OrderDialogState();
}

class _OrderDialogState extends ConsumerState<HistoryCommand> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final dialogWidth = MediaQuery.of(context).size.width * 0.9;
    final isDarkMode = ref.watch(darkModeProvider);

    // Définissez les couleurs dynamiquement
    final backgroundColor = isDarkMode ? kPrimaryDark : Colors.white;
    final textColor = isDarkMode ? kPrimaryWhite : Colors.black;
    final shadowColor =
        isDarkMode
            ? Colors.black.withOpacity(0.5)
            : Colors.black.withOpacity(0.25);
    final borderColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        width: dialogWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 14, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: dialogWidth * 0.5,
                    child: AutoSizeText(
                      'CMD N° - ${widget.orderNumber}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      minFontSize: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    height: dialogWidth * 0.1,
                    width: dialogWidth * 0.28,
                    decoration: BoxDecoration(
                      color:
                          widget.status == ''
                              ? kSecondaryGreen.withOpacity(0.28)
                              : kPrimaryRed.withOpacity(0.17),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        width: 2,
                        color:
                            widget.status == '' ? kPrimaryGreen : kPrimaryRed,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          widget.status == '' ? Icons.check : Icons.close,
                          color:
                              widget.status == '' ? kPrimaryGreen : kPrimaryRed,
                          size: 20,
                        ),
                        SizedBox(
                          width: dialogWidth * 0.15,
                          child: AutoSizeText(
                            widget.status == '' ? "Livrée" : "Annulée",
                            style: TextStyle(
                              color:
                                  widget.status == ''
                                      ? kPrimaryGreen
                                      : kPrimaryRed,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            minFontSize: 5,
                            maxFontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
              child: Row(
                children: [
                  // Date section
                  SizedBox(
                    width: dialogWidth * 0.4,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Calandar.svg',
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(width: 2),
                        Padding(
                          padding: EdgeInsets.only(top: 3.0),
                          child: SizedBox(
                            width: dialogWidth * 0.3,
                            child: AutoSizeText(
                              widget.date,
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              minFontSize: 5,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Color(0xFF000000), size: 16),
                        SizedBox(width: 2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 3.0),
                            child: AutoSizeText(
                              widget.personName,
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              minFontSize: 5,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Row(
                children: [
                  SizedBox(
                    width: dialogWidth * 0.4,
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Color(0xFF000000),
                          size: 16,
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 3.0),
                            child: AutoSizeText(
                              widget.heure,
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              minFontSize: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xFF000000),
                          size: 16,
                        ),

                        SizedBox(width: 2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 3.0),
                            child: AutoSizeText(
                              widget.location,
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              minFontSize: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: kLightGrayWhite,
                borderRadius:
                    !_expanded
                        ? BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                        : BorderRadius.zero,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(widget.imgUrl),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  widget.restaurantName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  minFontSize: 5,
                                  maxFontSize: 30,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 10),
                              AutoSizeText(
                                widget.price,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: kPrimaryRed,
                                ),
                                maxLines: 1,
                                minFontSize: 10,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 17,
                                      color: kMediumGray,
                                    ),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: AutoSizeText(
                                        widget.locaComm,
                                        style: TextStyle(
                                          color: kMediumGray,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        minFontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Visibility(
                                visible: !_expanded,
                                child: GestureDetector(
                                  onTap: () => setState(() => _expanded = true),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: kPrimaryRed,
                                    size: 27,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_expanded)
              Container(
                decoration: BoxDecoration(
                  color: kLightGrayWhite,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: dialogWidth * 0.4,
                          width: dialogWidth * 0.68,
                          decoration: BoxDecoration(
                            color: kPrimaryWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...widget.items.map(
                                    (item) => _buildOrderItemRow(item),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: [
                            const SizedBox(height: 12),
                            // Ligne pour "Total payé"
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  'Total payé',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  minFontSize: 10,
                                ),
                                AutoSizeText(
                                  widget.totalPrice,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: kPrimaryRed,
                                  ),
                                  minFontSize: 10,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  'Moyen de paiement',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 1,
                                  maxFontSize: 40,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/money.svg',
                                        height: 17,
                                        width: 17,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        widget.paymentMethod == 0
                                            ? "Espèces"
                                            : "Carte",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => setState(() => _expanded = false),
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: kPrimaryRed,
                              size: 27,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemRow(OrderItem2 item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              item.unite == 1
                  ? '${gramsToKg(item.quantity)} kg'
                  : 'x${item.quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: AutoSizeText(
              item.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              maxLines: 1,
              minFontSize: 5,
            ),
          ),
        ],
      ),
    );
  }
}
