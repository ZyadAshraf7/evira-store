import 'package:evira_store/presentation/cubits/category_products_cubit/category_product_cubit.dart';
import 'package:evira_store/presentation/cubits/category_products_cubit/category_product_cubit.dart';
import 'package:evira_store/presentation/screens/home_screen/widgets/get_all_products_box.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_theme.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProductCubit>().getCategoryProduct(widget.title.toLowerCase());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppTheme.primary500)),
      ),
      body: BlocBuilder<CategoryProductCubit, CategoryProductState>(
        builder: (context, state) {
          if(state is CategoryProductLoading){
            return Center(child:  loadingSpinner());
          }
          else if(state is CategoryProductFailed){
            return const Center(child: Text("SOMETHING WENT WRONG"));
          }
          return SingleChildScrollView(child: GetAllProductsBox(productsList: context.read<CategoryProductCubit>().categoryProducts));
        },
      ),
    );
  }
}
