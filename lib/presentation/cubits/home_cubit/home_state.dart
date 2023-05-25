part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class CategorySelected extends HomeState {}

class GetAllProductsWithLimitsInitial extends HomeState {}

class GetAllProductsWithLimitsLoading extends HomeState {}

class GetAllProductsWithLimitsDone extends HomeState {}

class GetAllProductsWithLimitsFailed extends HomeState {}
class SelectCategoryLoading extends HomeState {}
class SelectCategoryDone extends HomeState {}
class SelectCategoryFailed extends HomeState {}

