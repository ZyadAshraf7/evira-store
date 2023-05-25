import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/data/repositories/get_category_products/get_category_products_repository.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product.dart';
import '../../../data/repositories/get_all_products_with_limit/get_all_products_with_limit.dart';
import '../../../data/shared_preference/user_preference.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int selectedCategory = 0;
  List<String> categoriesList = [
    "All",
    "Smartphones",
    "Laptops",
    "Fragrances",
    "Skincare",
    "Groceries"
  ];

  selectCategory(int index) async {
    selectedCategory = index;
    print(categoriesList[selectedCategory]);
    if (index == 0) {
      fetchAllProductsWithLimit();
    }
    if (index == 1) {
      fetchDataOnCategory(1);
    }
    if (index == 2) {
      fetchDataOnCategory(2);
    }
    if (index == 3) {
      fetchDataOnCategory(3);
    }
    if (index == 4) {
      fetchDataOnCategory(4);
    }
    if (index == 5) {
      fetchDataOnCategory(5);
    }
    // emit(CategorySelected());
  }

  fetchDataOnCategory(int index) async {
    emit(SelectCategoryLoading());
    GetCategoryProductsRepository categoryProductsRepository =
        GetCategoryProductsRepository();
    final data = await categoryProductsRepository.getCategoryProducts(categoriesList[index]);
    final responseData = Product.fromJson(data);
    allProducts = responseData.products ?? [];
    if (allProducts.isNotEmpty) {
      emit(SelectCategoryDone());
    }
  }

  List<Products> allProducts = [];
  List<Products> smartphonesProducts = [];
  GetAllProductsWithLimitRepository repository =
      GetAllProductsWithLimitRepository();

  fetchAllProductsWithLimit() async {
    emit(GetAllProductsWithLimitsLoading());
    try {
      final data = await repository.getAllProductsWithLimits();
      final responseData = Product.fromJson(data);
      allProducts = responseData.products ?? [];
      if (allProducts.isNotEmpty) {
        emit(GetAllProductsWithLimitsDone());
      }
    } catch (e) {
      emit(GetAllProductsWithLimitsFailed());
    }
  }

}
