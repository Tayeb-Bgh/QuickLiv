import 'package:flutter/material.dart';

class NoGroceriesFound extends StatelessWidget {
  const NoGroceriesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.store_mall_directory_outlined,
            size: 60,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 10),
          Text(
            "Aucun magasin n'a été trouvé :(",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
