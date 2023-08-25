part of 'category_product_cubit.dart';

@immutable
abstract class CategoryProductState {}

class CategoryProductInitial extends CategoryProductState {}
class CategoryProductLoading extends CategoryProductState {}
class CategoryProductLoaded extends CategoryProductState {}
class CategoryProductFailed extends CategoryProductState {}
class CategoryProductEmpty extends CategoryProductState {}
