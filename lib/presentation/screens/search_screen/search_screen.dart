import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/presentation/cubits/search_product_cubit/search_product_cubit.dart';
import 'package:evira_store/presentation/widgets/custom_text_field.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_router/route_names.dart';
import '../home_screen/widgets/product_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchProductCubit>(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 22),
          child: Column(
            children: [
              CustomTextField(
                controller: cubit.searchController,
                hintText: "What are you searching for?",
                iconPath: "assets/icons/Search.svg",
                obsecure: false,
                onSubmit: (value) {
                  cubit.fetchSearchedProducts(value);
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<SearchProductCubit, SearchProductState>(
                builder: (context, state) {
                  if (state is SearchProductLoading) {
                    return loadingSpinner();
                  }
                  if (state is SearchProductInitial) {
                    return Center(
                      child: Column(
                        children: [
                          SvgPicture.asset("assets/icons/notFoundResult.svg"),
                          const SizedBox(height: 40),
                          SizedBox(
                              width: 400,
                              child: Text("What are you searching for today ?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: AppTheme.grey900),
                                  textAlign: TextAlign.center))
                        ],
                      ),
                    );
                  } else {
                    if (state is SearchProductNotFound) {
                      print("Not found");
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Results for " "${cubit.searchController.text}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: AppTheme.primary500),
                              ),
                              const Text("0 found"),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/notFoundResult.svg"),
                                const SizedBox(height: 40),
                                SizedBox(
                                    width: 400,
                                    child: Text("Not Found",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(color: AppTheme.grey900),
                                        textAlign: TextAlign.center)),
                                const SizedBox(height: 12),
                                const Text(
                                    "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
                                    textAlign: TextAlign.center,
                                    style: AppTheme.bodyXLargeRegular),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is SearchProductFound) {
                      /*print("found");
                      print(cubit.searchedProducts.length);*/
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Results for " "${cubit.searchController.text}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: AppTheme.primary500),
                              ),
                              Text("${cubit.searchedProducts.length} found"),
                            ],
                          ),
                          const SizedBox(height: 30),
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 24,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    RouteNames.detailsScreen,
                                    arguments: cubit.searchedProducts[i],
                                  );
                                },
                                child: ProductCard(
                                  product: cubit.searchedProducts[i],
                                ),
                              );
                            },
                            itemCount: cubit.searchedProducts.length,
                          ),
                        ],
                      );
                    } else {
                      print("error");
                      return SizedBox();
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
