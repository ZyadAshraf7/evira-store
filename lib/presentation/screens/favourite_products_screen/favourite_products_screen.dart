import 'package:evira_store/presentation/cubits/favourite_products_cubit/favourite_products_cubit.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/get_all_products_box.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_router/route_names.dart';
import '../../../core/theme/app_theme.dart';
import '../home_screen/widgets/product_card.dart';

class FavouriteProductsScreen extends StatelessWidget {
  const FavouriteProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavouriteProductsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("My Wishlist",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppTheme.primary500)),
      ),
      body: BlocBuilder<FavouriteProductsCubit, FavouriteProductsState>(
        builder: (context, state) {
          if(state is FavouriteProductsLoading){
            return Center(child: loadingSpinner());
          }
          return GetAllProductsBox(productsList: cubit.favouriteProducts);
        },
      ),
    );
  }
}
