import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:evira_store/presentation/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:evira_store/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/categories_box.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/get_all_products_box.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/user_information_box.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
        body: ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () async {
            Navigator.of(context).pushNamed(RouteNames.searchScreen);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: AppTheme.grey200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/Search.svg"),
                    const SizedBox(width: 12),
                    Text("Search",
                        style: AppTheme.bodyMediumRegular
                            .copyWith(color: AppTheme.grey500))
                  ],
                ),
                SvgPicture.asset("assets/icons/Filter.svg"),
              ],
            ),
          ),
        ),
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
                      cubit.selectCategory(i);
                    },
                    child: CategoriesBox(
                      isSelected: cubit.selectedCategory == i,
                      title: cubit.categoriesList[i],
                    ),
                  );
                },
                itemCount: cubit.categoriesList.length,
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
            /*if (state is GetAllProductsWithLimitsDone || state is SelectCategoryDone) {
              return GetAllProductsBox(cubit: cubit);
            }*/else{
              return GetAllProductsBox(productsList:cubit.allProducts);
            }
          },
        )
      ],
    ));
  }
}

