import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:evira_store/presentation/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:evira_store/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/categories_box.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/get_all_products_box.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/special_offers_box.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/user_information_box.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/repositories/get_home_categories_repository/get_home_categories_repository.dart';
import 'widgets/categories_circles_box.dart';
import 'widgets/category_circle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<HomeCubit>(context);
    print("BUILD AGAIN..");
    return Scaffold(
        body: ListView(
        children: [
        BlocBuilder<GetUserInfoCubit, GetUserInfoState>(
          builder: (context, state) {
            if (state is GetUserInfoLoading) {
              return loadingSpinner();
            } else {
              return const UserInformationBox();
            }
          },
        ),
        // const SizedBox(height: 24),
        // SearchBox(),
        const SizedBox(height: 24),
        const SpecialOffersBox(),
        const SizedBox(height: 24),
        const CategoriesCirclesBox(),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Most Popular",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.grey900),
          ),
        ),
        const SizedBox(height: 14),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return SizedBox(
              height: 40,
              child: ListView.separated(
                separatorBuilder: (context, _) {
                  return const SizedBox(width: 12);
                },
                padding: const EdgeInsets.only(left: 24),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<HomeCubit>(context,listen: false).selectCategory(i);
                    },
                    child: CategoriesBox(
                      isSelected: BlocProvider.of<HomeCubit>(context).selectedCategory == i,
                      title: BlocProvider.of<HomeCubit>(context).categoriesList[i],
                    ),
                  );
                },
                itemCount: BlocProvider.of<HomeCubit>(context).categoriesList.length,
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetAllProductsWithLimitsLoading || state is SelectCategoryLoading ) {
              return loadingSpinner();
            }
            else if (state is GetAllProductsWithLimitsFailed || state is SelectCategoryFailed){
              return const Center(child: Text("Somthing Went Wrong"));
            }else{
              return GetAllProductsBox(productsList:BlocProvider.of<HomeCubit>(context).allProducts);
            }
          },
        )
      ],
    ));
  }
}
