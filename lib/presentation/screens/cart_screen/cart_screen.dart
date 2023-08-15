import 'package:evira_store/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:evira_store/presentation/screens/cart_screen/widgets/cart_product_card.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_router/route_names.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/user.dart';
import '../../cubits/get_user_info/get_user_info_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              SvgPicture.asset("assets/icons/logo_black.svg"),
              const SizedBox(width: 16),
              Text("My Cart",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: AppTheme.primary500)),
            ],
          ),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartProductsLoading) {
              return Center(
                child: loadingSpinner(),
              );
            }else if(state is CartProductsEmpty){
              return Center(child: Text("Cart is empty"),);
            }
            return BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: cubit.cartList.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemBuilder: (context, i) {
                            return CartProductCard(product: cubit.cartList[i]);
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      height: 80,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total price",
                                  style: AppTheme.bodySmallSemiBold
                                      .copyWith(color: AppTheme.grey600)),
                              const SizedBox(height: 6),
                              Text("\$${cubit.calculateTotalPrices().toStringAsFixed(2)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: AppTheme.grey900)),
                            ],
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final UserModel user = BlocProvider.of<GetUserInfoCubit>(context).currentUser;
                                Navigator.of(context).pushNamed(RouteNames.checkoutScreen,arguments: [cubit.cartList,user]);
                              },
                              style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.all<double>(10),
                                minimumSize:
                                    MaterialStateProperty.resolveWith<Size>(
                                        (Set<MaterialState> states) {
                                  return const Size(100, 55);
                                }),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppTheme.primary500),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Checkout",
                                      style: AppTheme.bodyLargeBold
                                          .copyWith(color: Colors.white)),
                                  const SizedBox(width: 19),
                                  SvgPicture.asset(
                                      "assets/icons/Arrow _Right_rounded.svg",
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ));
  }
}
