import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  final String imgUrl;
  final String nameProd;
  final String descProd;
  final String priceProd;
  const ProductCard({
    super.key,
    required this.imgUrl,
    required this.nameProd,
    required this.descProd,
    required this.priceProd,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SvgPicture.asset(imgUrl, width: 90, height: 90),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product name
                        Text(
                          nameProd,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'roboto',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Product description
                        Expanded(
                          child: Text(
                            descProd,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF686868),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'roboto',
                            ),
                            maxLines: 3,
                          ),
                        ),

                        // Price and add button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Price
                            Text(
                              priceProd,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE13838),
                                fontFamily: 'roboto',
                              ),
                            ),

                            IconButton(
                              icon: Image.asset(
                                'assets/images/Add_to_panier.png',
                              ),
                              iconSize: 33,
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
