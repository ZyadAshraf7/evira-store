import 'package:flutter/material.dart';

import 'category_circle.dart';

class CategoriesCirclesBox extends StatelessWidget {
  const CategoriesCirclesBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryCircle(iconPath: "assets/icons/clothes.svg",title: "Clothes"),
              CategoryCircle(iconPath: "assets/icons/shoes.svg",title: "Shoes"),
              CategoryCircle(iconPath: "assets/icons/Bag_selected.svg",title: "Bags"),
              CategoryCircle(iconPath: "assets/icons/electronics.svg",title: "Electronics"),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryCircle(iconPath: "assets/icons/watches.svg",title: "Watches"),
              CategoryCircle(iconPath: "assets/icons/jewelery.svg",title: "Jewelry"),
              CategoryCircle(iconPath: "assets/icons/kitchen.svg",title: "Kitchen"),
              CategoryCircle(iconPath: "assets/icons/toys.svg",title: "Toys"),
            ],
          ),
        ],
      ),
    );
  }
}
