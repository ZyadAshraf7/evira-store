part of 'favourite_products_cubit.dart';

@immutable
abstract class FavouriteProductsState {}

class FavouriteProductsInitial extends FavouriteProductsState {}
class FavouriteProductsLoading extends FavouriteProductsState {}
class FavouriteProductsDone extends FavouriteProductsState {}
class FavouriteProductsFailed extends FavouriteProductsState {}

class AddProductToFavourite extends FavouriteProductsState {}
class RemoveProductToFavourite extends FavouriteProductsState {}
