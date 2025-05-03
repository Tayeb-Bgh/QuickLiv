import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderItem2 {
  final String name;
  final double price;
  final int quantity;

  OrderItem2({required this.name, required this.price, required this.quantity});
}

class HistoryCommand extends StatefulWidget {
  final String orderNumber;
  final String imgUrl;
  final List<OrderItem2> items;
  final String restaurantName;
  final String status;
  final String date;
  final String personName;
  final String locaComm;
  final String price;
  final String totalPrice;
  final String paymentMethod;
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
  State<HistoryCommand> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<HistoryCommand> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final dialogWidth = MediaQuery.of(context).size.width * 0.9;
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
              color: Colors.black.withOpacity(0.3),
              blurRadius: 7,
              offset: Offset(0, 2),
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
                        fontSize: 25,
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
                      color: Color(0xFF47CF5B).withOpacity(0.28),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 2, color: Color(0xFF34EB4F)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.check, color: Color(0xFF34EB4F), size: 20),
                        SizedBox(
                          width: dialogWidth * 0.15,
                          child: AutoSizeText(
                            widget.status,
                            style: TextStyle(
                              color: Color(0xFF34EB4F),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            minFontSize: 5,
                            maxFontSize: 20,
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
                        Icon(
                          Icons.calendar_today,
                          color: Color(0xFF000000),
                          size: 16,
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
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
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
                                fontSize: 12,
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
                                fontWeight: FontWeight.w700,
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
              color: Color(0xFFEEEEEE),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 22.5,
                      child: Image.network(widget.imgUrl, fit: BoxFit.contain),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                                AutoSizeText(
                                  widget.price,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFFE13838),
                                  ),
                                  maxLines: 1,
                                  minFontSize: 10,
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        '../assets/images/Location.svg',
                                        width: 17,
                                        height: 17,
                                        colorFilter: ColorFilter.mode(
                                          Color(0xFF686868),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      Expanded(
                                        child: AutoSizeText(
                                          widget.locaComm,
                                          style: TextStyle(
                                            color: Color(0xFF686868),
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          minFontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Visibility(
                                  visible: !_expanded,
                                  child: GestureDetector(
                                    onTap:
                                        () => setState(() => _expanded = true),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,

                                      color: Color(0xFFE13838),
                                      size: 27,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_expanded)
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),

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
                          width: dialogWidth * 0.65,
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                            // Total price row
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
                                    color: Color(0xFFE13838),
                                  ),
                                  minFontSize: 10,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Moyen de paiement',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.money, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.paymentMethod,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
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
                              color: Color(0xFFE13838),
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
            width: 30,
            child: Text(
              'x${item.quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Expanded(
            child: AutoSizeText(
              item.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              maxLines: 1,
              minFontSize: 5,
            ),
          ),
        ],
      ),
    );
  }
}
