import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/product.dart';

class GetAllProductsBox extends StatelessWidget {
  const GetAllProductsBox({
    super.key, required this.productsList,
  });

  // final HomeCubit cubit;
  final List<Product> productsList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          childAspectRatio: 0.5
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(RouteNames.detailsScreen,arguments: productsList[i],
              );
            },
            child: ProductCard(
              product: productsList[i],
            ),
          );
        },
        itemCount: productsList.length,
      ),
    );
  }
}
