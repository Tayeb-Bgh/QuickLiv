import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';

class GroceryCard extends StatelessWidget {
  final bool isFull;
  final Grocery grocery;

  const GroceryCard({super.key, required this.grocery, this.isFull = true});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: isFull ? height * 0.5 : height * 0.35,
        width: isFull ? width * 0.9 : width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  Image.network(
                    grocery.imgUrl,
                    width: double.infinity,
                    height: height * 0.2,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap:
                          () => {print("${grocery.name} ajouté à favoris !")},
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: const Color(0xFFD9D9D9),
                        ),
                        child: Icon(
                          grocery.liked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              grocery.liked ? Color(0xFFE13838) : Colors.grey,
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      grocery.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 2,
                      minFontSize: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AutoSizeText(
                        grocery.description,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Row(
                      spacing: 2,
                      children: [
                        Icon(Icons.delivery_dining, size: 11),
                        Text(
                          "${grocery.delivPrice}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 2),

                        Icon(Icons.access_time, size: 11, color: Colors.red),

                        Text(
                          parseTime(grocery.delivTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 2),

                        Icon(Icons.star, size: 11, color: Colors.amber),

                        Text(
                          grocery.rating.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
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
    );
  }
}
