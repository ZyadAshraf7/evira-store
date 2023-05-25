part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class CartProductsLoading extends CartState {}
class CartProductsDone extends CartState {}
class CartProductsFailed extends CartState {}
class IncrementQuantity extends CartState {}
class DecrementQuantity extends CartState {}
class RemoveProductFromCart extends CartState {}
class TotalPriceChange extends CartState {}
