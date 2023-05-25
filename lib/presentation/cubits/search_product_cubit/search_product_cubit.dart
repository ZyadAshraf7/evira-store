import 'package:bloc/bloc.dart';
import 'package:evira_store/data/repositories/search_product/search_product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product.dart';

part 'search_product_state.dart';

class SearchProductCubit extends Cubit<SearchProductState> {
  SearchProductCubit() : super(SearchProductInitial());

  TextEditingController searchController = TextEditingController();
   List<Products> searchedProducts=[];
  SearchProductRepository searchProductRepository = SearchProductRepository();
  fetchSearchedProducts(String searchKeyword )async{
    emit(SearchProductLoading());
    try{
      final responseData = await searchProductRepository.searchProduct(searchKeyword);
      final response = Product.fromJson(responseData);
      searchedProducts = response.products!;
      // searchedProducts = productsResponse.map((e) => Products.fromJson(e)).toList();
      print(searchedProducts.first.title);
      if(searchedProducts.isEmpty){
        emit(SearchProductNotFound());
      }else{
        emit(SearchProductFound());
      }

    }catch(e){
      emit(SearchProductError());
      print(e.toString());
    }
  }
}
