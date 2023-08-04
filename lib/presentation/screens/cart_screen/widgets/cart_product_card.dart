import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/product.dart';
import '../../../cubits/cart_cubit/cart_cubit.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({Key? key, required this.product,this.isCheckout,this.checkoutQuantity}) : super(key: key);

  final Product product;
  final bool ?isCheckout;
  final int ? checkoutQuantity;
  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(product.image!,height: 120,width: 120,fit: BoxFit.cover,),
            ),
            const SizedBox(width: 16),
            Container(
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(product.title!,overflow: TextOverflow.ellipsis,maxLines:2,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.grey900))),
                        (isCheckout==null||isCheckout==false)?GestureDetector(onTap:()=> cartCubit.removeProductFromCart(product),
                            child: SvgPicture.asset("assets/icons/Delete.svg")):const SizedBox(),

                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SvgPicture.asset(product.rating!.rate! > 4.5
                            ? "assets/icons/FullStar.svg"
                            : "assets/icons/HalfStar.svg"),
                        const SizedBox(width: 8),
                        Text(
                          product.rating!.rate.toString(),
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
                            "${product.rating!.count} reviews",
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
                        (isCheckout==null||isCheckout==false)?
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
                                Text(product.quantity.toString(),style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primary500)),
                                GestureDetector(onTap: ()=>cartCubit.incrementProductQuantity(product)
                                    ,child: SvgPicture.asset("assets/icons/plus.svg")),
                              ],
                            ),
                          ),
                        ):Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xffF3F3F3),
                            shape: BoxShape.circle
                          ),
                          child: Text(checkoutQuantity.toString()??0.toString(),style: AppTheme.bodyMediumBold.copyWith(color: AppTheme.primary500)),
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
