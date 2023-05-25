import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/data/models/product.dart';
import 'package:evira_store/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../cubits/favourite_products_cubit/favourite_products_cubit.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Products product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavouriteProductsCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.product.imageUrl ?? "",
                    fit: BoxFit.cover,
                    // height: 350,
                    width: 500,
                  )),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: AppTheme.blackGradient,
                  ),
                  child: GestureDetector(
                      onTap: () {
                        cubit.toggleProductsToFavorite(widget.product);
                      },
                      child: BlocBuilder<FavouriteProductsCubit, FavouriteProductsState>(
                            builder: (context, state) {
                              return SvgPicture.asset(
                                cubit.checkIfProductFavourite(widget.product)?"assets/icons/HeartFill.svg":"assets/icons/Heart.svg",
                                color: Colors.white,
                                fit: BoxFit.scaleDown,
                                width: 20,
                                height: 20,
                              );
                            },
                          )),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(widget.product.title ?? "",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppTheme.grey900)),
        const SizedBox(height: 10),
        Row(
          children: [
            SvgPicture.asset(widget.product.rating == 5
                ? "assets/icons/FullStar.svg"
                : "assets/icons/HalfStar.svg"),
            const SizedBox(width: 8),
            Text(
              widget.product.rating.toString(),
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
                "${widget.product.stock} left in stock",
                style: AppTheme.bodyXSmallSemiBold,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Text("\$${widget.product.price}",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppTheme.grey900))
      ],
    );
  }
}
