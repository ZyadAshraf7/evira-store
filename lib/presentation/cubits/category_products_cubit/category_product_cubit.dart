import 'package:bloc/bloc.dart';
import 'package:evira_store/data/models/product.dart';
import 'package:evira_store/data/repositories/get_home_categories_repository/get_home_categories_repository.dart';
import 'package:meta/meta.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  CategoryProductCubit() : super(CategoryProductInitial());

  List<Product> categoryProducts = [];
  GetHomeCategoriesRepository repository = GetHomeCategoriesRepository();

  Future <void>getCategoryProduct(String category)async{

    try{
      categoryProducts.clear();
      emit(CategoryProductLoading());
      final dataResponse = await repository.fetchHomeCategories(category);
      categoryProducts = dataResponse.map((e) => Product.fromJson(e)).toList();
      if(categoryProducts.isNotEmpty){
        emit(CategoryProductLoaded());
      }else{
        emit(CategoryProductEmpty());
      }
    }catch(e){
      emit(CategoryProductFailed());
      print(e.toString());
    }
    print("GETTING PRODUCTS ..");
  }
}
