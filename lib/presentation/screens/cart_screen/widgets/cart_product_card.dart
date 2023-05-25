import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/product.dart';
import '../../../cubits/cart_cubit/cart_cubit.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({Key? key, required this.product}) : super(key: key);

  final Products product;
  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(product.imageUrl!,height: 120,width: 120,fit: BoxFit.cover,),
            ),
            const SizedBox(width: 16),
            Container(
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(product.title!,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.grey900))),
                        GestureDetector(onTap:()=> cartCubit.removeProductFromCart(product),
                            child: SvgPicture.asset("assets/icons/Delete.svg")),

                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SvgPicture.asset(product.rating == 5
                            ? "assets/icons/FullStar.svg"
                            : "assets/icons/HalfStar.svg"),
                        const SizedBox(width: 8),
                        Text(
                          product.rating.toString(),
                          style:
                          AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey700),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 15,
                          width: 2,
                          color: AppTheme.grey700,
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.grey200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "${product.stock} left in stock",
                            style: AppTheme.bodyXSmallSemiBold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${product.price?.toDouble()}",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.grey900)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.grey200,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(onTap: ()=>cartCubit.decrementProductQuantity(product)
                                    ,child: SvgPicture.asset("assets/icons/minus.svg")),
                                const SizedBox(width: 16),
                                Text(product.quantity.toString(),style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primary500)),
                                const SizedBox(width: 20),
                                GestureDetector(onTap: ()=>cartCubit.incrementProductQuantity(product)
                                    ,child: SvgPicture.asset("assets/icons/plus.svg")),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
