part of 'search_product_cubit.dart';

@immutable
abstract class SearchProductState {}

class SearchProductInitial extends SearchProductState {}

class SearchProductLoading extends SearchProductState {}

class SearchProductFound extends SearchProductState {}

class SearchProductNotFound extends SearchProductState {}

class SearchProductError extends SearchProductState {}
