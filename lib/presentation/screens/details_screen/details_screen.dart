import 'package:carousel_slider/carousel_slider.dart';
import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/data/models/product.dart';
import 'package:evira_store/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:evira_store/presentation/cubits/favourite_products_cubit/favourite_products_cubit.dart';
import 'package:evira_store/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../cubits/home_cubit/home_cubit.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _current = 0;
  // int _quantity = 1;
  int _totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    // final CarouselController _controller = CarouselController();
    final cubit = BlocProvider.of<FavouriteProductsCubit>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 12),
                child: IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              Hero(tag: widget.product.id.toString(),child: Image.network(widget.product.image!)),
              const SizedBox(height:24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: Text(widget.product.title!,style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.grey900),maxLines: null,)),
                        GestureDetector(
                          onTap: (){
                            cubit.toggleProductsToFavorite(widget.product);

                          },
                          child: BlocBuilder<FavouriteProductsCubit,FavouriteProductsState>(
                                  builder: (context, state) {
                                    return SvgPicture.asset(
                                      cubit.checkIfProductFavourite(widget.product)?"assets/icons/HeartFill.svg":"assets/icons/Heart.svg",
                                    color: AppTheme.primary500,
                                    width: 26,
                                    height: 26,
                                  );
                                  },
                                )
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.grey200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "${widget.product.rating!.count} reviews",
                            style: AppTheme.bodyXSmallSemiBold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        SvgPicture.asset(widget.product.rating!.rate!>4.5?"assets/icons/FullStar.svg":"assets/icons/HalfStar.svg"),
                        const SizedBox(width: 8),
                        Text(widget.product.rating!.rate.toString(),style: AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey700),)

                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppTheme.grey300),
                    const SizedBox(height: 16),
                    Text("Description",style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(widget.product.description!,style: AppTheme.bodyMediumRegular.copyWith(color: AppTheme.grey800)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text("Quantity",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.grey900)),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 24),
                          decoration: BoxDecoration(
                            color: AppTheme.grey200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(onTap: (){
                                setState(() {
                                  widget.product.quantity!<=1?widget.product.quantity!=1:(widget.product.quantity=widget.product.quantity!-1);
                                });
                              },child: SvgPicture.asset("assets/icons/minus.svg")),
                              const SizedBox(width: 20),
                              Text(widget.product.quantity.toString(),style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primary500)),
                              const SizedBox(width: 20),
                              GestureDetector(onTap: (){setState(() {
                                widget.product.quantity = widget.product.quantity!+1;
                              });},child: SvgPicture.asset("assets/icons/plus.svg")),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 55),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("Total price",style: AppTheme.bodySmallSemiBold.copyWith(color: AppTheme.grey600)),
                            const SizedBox(height: 6),
                            Text("\$${widget.product.price!*widget.product.quantity!}",style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.grey900)),
                          ],
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: (){
                              BlocProvider.of<CartCubit>(context).addProductToCart(widget.product);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product is Added to Cart"),duration: Duration(milliseconds: 500),));
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(10),
                              minimumSize: MaterialStateProperty.resolveWith<Size>(
                                      (Set<MaterialState> states) {
                                    return const Size(100, 55);
                                  }
                              ),
                              shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primary500),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  SvgPicture.asset("assets/icons/Bag_selected.svg",color: Colors.white),
                                const SizedBox(width: 19),
                                Text("Add to Cart",style: AppTheme.bodyLargeBold.copyWith(color: Colors.white),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
